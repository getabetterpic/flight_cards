export class App {
  static initApp() {
    document.addEventListener('turbolinks:load', () => {
      const elems = document.querySelectorAll('.sidenav');
      const sidenav = window.M.Sidenav.init(elems, {})[0];

      const trigger = document.getElementById('sidenav-trigger');
      trigger.addEventListener('click', (event) => {
        event.preventDefault();
        if (!sidenav) { return; }
        if (sidenav.isOpen) {
          sidenav.close();
        } else {
          sidenav.open();
        }
      });
    });
  }
}
