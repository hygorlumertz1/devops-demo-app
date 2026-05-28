/**
 * @jest-environment jsdom
 */

describe('Theme toggle', () => {
  let root, toggle;

  beforeEach(() => {
    document.body.innerHTML = `
      <button id="theme-toggle">🌙</button>
    `;
    root = document.documentElement;
    root.setAttribute('data-theme', 'dark');
    toggle = document.getElementById('theme-toggle');

    toggle.addEventListener('click', () => {
      const next = root.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
      root.setAttribute('data-theme', next);
      toggle.textContent = next === 'dark' ? '🌙' : '☀️';
    });
  });

  test('inicia no tema escuro', () => {
    expect(root.getAttribute('data-theme')).toBe('dark');
  });

  test('alterna para tema claro ao clicar', () => {
    toggle.click();
    expect(root.getAttribute('data-theme')).toBe('light');
    expect(toggle.textContent).toBe('☀️');
  });

  test('volta para tema escuro ao clicar novamente', () => {
    toggle.click();
    toggle.click();
    expect(root.getAttribute('data-theme')).toBe('dark');
    expect(toggle.textContent).toBe('🌙');
  });
});
