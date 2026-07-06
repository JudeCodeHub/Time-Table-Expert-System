from pathlib import Path

from flask import Flask, jsonify
from flask_cors import CORS

try:
    from pyswip import Prolog
except Exception as exc:
    Prolog = None
    PROLOG_IMPORT_ERROR = exc
else:
    PROLOG_IMPORT_ERROR = None


app = Flask(__name__)
CORS(app)

prolog = None
prolog_loaded = False
prolog_load_error = None


def _to_json_value(value):
    if isinstance(value, bytes):
        return value.decode("utf-8")
    return value


def _query_prolog(query_text):
    if not prolog_loaded or prolog is None:
        if prolog_load_error:
            raise RuntimeError(str(prolog_load_error))
        raise RuntimeError("Prolog engine is not initialized")

    try:
        return list(prolog.query(query_text))
    except Exception as exc:
        raise RuntimeError(f"Prolog query failed: {query_text}") from exc


def initialize_prolog():
    global prolog, prolog_loaded, prolog_load_error

    if Prolog is None:
        prolog_loaded = False
        prolog_load_error = (
            PROLOG_IMPORT_ERROR or RuntimeError("pyswip is unavailable")
        )
        return

    try:
        prolog = Prolog()
        prolog_file = (
            Path(__file__).resolve().parent.parent
            / "prolog"
            / "timetable.pl"
        ).resolve()
        prolog.consult(str(prolog_file))
        prolog_loaded = True
        prolog_load_error = None
    except Exception as exc:
        prolog_loaded = False
        prolog_load_error = exc


@app.get("/api/courses")
def get_courses():
    try:
        rows = _query_prolog("course(Id, Name, Type)")
        courses = [
            {
                "id": _to_json_value(row.get("Id")),
                "name": _to_json_value(row.get("Name")),
                "type": _to_json_value(row.get("Type")),
            }
            for row in rows
        ]
        return jsonify(courses)
    except Exception as exc:
        return jsonify({"error": f"Failed to fetch courses: {str(exc)}"}), 500


@app.post("/api/generate")
def generate_timetable():
    try:
        _query_prolog("generate_timetable")

        timetable_rows = _query_prolog("schedule(Course, Day, Time)")
        timetable = [
            {
                "course": _to_json_value(row.get("Course")),
                "day": _to_json_value(row.get("Day")),
                "time": _to_json_value(row.get("Time")),
            }
            for row in timetable_rows
        ]

        verification_rows = _query_prolog(
            "required_hours(Course, Required), scheduled_hours(Course, Got)"
        )
        warnings = []
        for row in verification_rows:
            course_id = _to_json_value(row.get("Course"))
            required = int(_to_json_value(row.get("Required")))
            got = int(_to_json_value(row.get("Got")))
            if got < required:
                warnings.append(
                    {
                        "course": course_id,
                        "required_hours": required,
                        "scheduled_hours": got,
                    }
                )

        return jsonify({"timetable": timetable, "warnings": warnings})
    except Exception as exc:
        return jsonify({"error": f"Failed to generate timetable: {str(exc)}"}), 500


@app.get("/api/timetable")
def get_timetable():
    try:
        rows = _query_prolog("schedule(Course, Day, Time)")
        timetable = [
            {
                "course": _to_json_value(row.get("Course")),
                "day": _to_json_value(row.get("Day")),
                "time": _to_json_value(row.get("Time")),
            }
            for row in rows
        ]
        return jsonify({"timetable": timetable})
    except Exception as exc:
        return jsonify({"error": f"Failed to fetch timetable: {str(exc)}"}), 500


@app.post("/api/reset")
def reset_timetable():
    try:
        _query_prolog("cleanup")
        return jsonify({"status": "ok"})
    except Exception as exc:
        return jsonify({"error": f"Failed to reset timetable: {str(exc)}"}), 500


@app.get("/api/health")
def health():
    try:
        rows = _query_prolog("course(Course, Name, Type)")
        return jsonify(
            {
                "status": "ok",
                "prolog_loaded": True,
                "course_count": len(rows),
            }
        )
    except Exception as exc:
        return jsonify(
            {
                "error": f"Health check failed: {str(exc)}",
                "prolog_loaded": False,
            }
        ), 500


initialize_prolog()


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)

