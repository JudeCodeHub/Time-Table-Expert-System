const API_BASE = 'http://127.0.0.1:5000/api';

const TIME_SLOTS = ['830', '930', '1030', '1130', '1330', '1430', '1530'];
const TIME_LABELS = {
    '830': '8:30 AM',
    '930': '9:30 AM',
    '1030': '10:30 AM',
    '1130': '11:30 AM',
    '1330': '1:30 PM',
    '1430': '2:30 PM',
    '1530': '3:30 PM'
};
const DAYS = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday'];

let coursesMap = {}; // id -> { id, name, type }

const ui = {
    healthBanner: document.getElementById('health-banner'),
    btnGenerate: document.getElementById('btn-generate'),
    btnReset: document.getElementById('btn-reset'),
    loading: document.getElementById('loading'),
    warningsBox: document.getElementById('warnings-box'),
    warningsList: document.getElementById('warnings-list'),
    errorsBox: document.getElementById('errors-box'),
    errorMessage: document.getElementById('error-message'),
    timetableGrid: document.getElementById('timetable-grid'),
    gridBody: document.querySelector('#timetable-grid tbody'),
    emptyState: document.getElementById('empty-state')
};

async function init() {
    ui.btnGenerate.addEventListener('click', generateTimetable);
    ui.btnReset.addEventListener('click', resetTimetable);

    try {
        await checkHealth();
        await fetchCourses();
        await fetchCurrentTimetable();
    } catch (e) {
        console.error("Init error:", e);
    }
}

async function checkHealth() {
    try {
        const res = await fetch(`${API_BASE}/health`);
        if (!res.ok) throw new Error('Network response was not ok');
        const data = await res.json();
        
        if (!data.prolog_loaded || data.status !== 'ok') {
            showBackendError();
        }
    } catch (err) {
        showBackendError();
        throw err;
    }
}

function showBackendError() {
    ui.healthBanner.classList.remove('hidden');
    ui.btnGenerate.disabled = true;
    ui.btnReset.disabled = true;
}

async function fetchCourses() {
    try {
        const res = await fetch(`${API_BASE}/courses`);
        if (!res.ok) throw new Error('Failed to fetch courses');
        const courses = await res.json();
        courses.forEach(c => {
            coursesMap[c.id] = c;
        });
    } catch (err) {
        console.error("Error fetching courses:", err);
    }
}

async function fetchCurrentTimetable() {
    try {
        const res = await fetch(`${API_BASE}/timetable`);
        if (!res.ok) throw new Error('Failed to fetch timetable');
        const data = await res.json();
        
        if (data.timetable && data.timetable.length > 0) {
            renderGrid(data.timetable);
        } else {
            showEmptyState();
        }
    } catch (err) {
        console.error("Error fetching current timetable:", err);
        showEmptyState();
    }
}

async function generateTimetable() {
    clearUI();
    ui.loading.classList.remove('hidden');
    ui.btnGenerate.disabled = true;
    ui.btnReset.disabled = true;

    try {
        const res = await fetch(`${API_BASE}/generate`, { method: 'POST' });
        const data = await res.json();

        if (!res.ok) {
            throw new Error(data.error || 'Server error');
        }

        renderGrid(data.timetable);

        if (data.warnings && data.warnings.length > 0) {
            showWarnings(data.warnings);
        }
    } catch (err) {
        showError(err.message);
        showEmptyState();
    } finally {
        ui.loading.classList.add('hidden');
        ui.btnGenerate.disabled = false;
        ui.btnReset.disabled = false;
    }
}

async function resetTimetable() {
    clearUI();
    ui.btnGenerate.disabled = true;
    ui.btnReset.disabled = true;

    try {
        const res = await fetch(`${API_BASE}/reset`, { method: 'POST' });
        if (!res.ok) throw new Error('Reset failed');
        showEmptyState();
    } catch (err) {
        showError(err.message);
    } finally {
        ui.btnGenerate.disabled = false;
        ui.btnReset.disabled = false;
    }
}

function renderGrid(timetable) {
    ui.emptyState.classList.add('hidden');
    ui.timetableGrid.classList.remove('hidden');
    
    // Create a lookup: day -> time -> course_id
    const schedule = {};
    timetable.forEach(entry => {
        if (!schedule[entry.day]) schedule[entry.day] = {};
        schedule[entry.day][entry.time] = entry.course;
    });

    let html = '';
    
    for (const time of TIME_SLOTS) {
        html += `<tr>`;
        html += `<td>${TIME_LABELS[time]}</td>`;
        
        for (const day of DAYS) {
            const courseId = schedule[day] && schedule[day][time];
            
            if (courseId) {
                const courseInfo = coursesMap[courseId] || { name: 'Unknown Course' };
                html += `<td><span class="course-cell" title="${courseInfo.name}">${courseId.toUpperCase()}</span></td>`;
            } else {
                html += `<td>-</td>`;
            }
        }
        
        html += `</tr>`;
    }
    
    ui.gridBody.innerHTML = html;
}

function showEmptyState() {
    ui.timetableGrid.classList.add('hidden');
    ui.emptyState.classList.remove('hidden');
}

function showWarnings(warnings) {
    ui.warningsBox.classList.remove('hidden');
    ui.warningsList.innerHTML = warnings.map(w => `<li>${w}</li>`).join('');
}

function showError(message) {
    ui.errorsBox.classList.remove('hidden');
    ui.errorMessage.textContent = message;
}

function clearUI() {
    ui.warningsBox.classList.add('hidden');
    ui.errorsBox.classList.add('hidden');
    ui.gridBody.innerHTML = '';
}

// Start
init();
