const toggle = document.getElementById('theme-toggle');
const root = document.documentElement;

const saved = localStorage.getItem('theme') || 'dark';
root.setAttribute('data-theme', saved);
toggle.textContent = saved === 'dark' ? '🌙' : '☀️';

toggle.addEventListener('click', () => {
  const next = root.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
  root.setAttribute('data-theme', next);
  toggle.textContent = next === 'dark' ? '🌙' : '☀️';
  localStorage.setItem('theme', next);
});
