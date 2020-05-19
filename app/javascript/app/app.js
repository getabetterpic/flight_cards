export class App {
  static initApp() {
    document.addEventListener('turbolinks:load', () => {
      App.setupSidenav();
      App.setupAlertClose();
      M.updateTextFields();
    });
  }

  static setupSidenav() {
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
  }

  static setupAlertClose() {
    const buttons = document.getElementsByClassName('flash-close');
    for (let button of buttons) {
      button.addEventListener('click', (event) => {
        if (event.target && event.target.parentNode && event.target.parentNode.parentNode) {
          event.target.parentNode.parentNode.remove();
        }
      });
    }
  }
}
