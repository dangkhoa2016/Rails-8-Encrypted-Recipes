
window.getOpenedModal = function (modalId) {
  let modalElememt = null;
  if (modalId) {
    frame = document.querySelector(`turbo-frame#${modalId}`);
    if (frame) {
      modalElememt = frame.closest('.modal');
      if (modalElememt && !modalElememt.classList.contains('show'))
        modalElememt = null;
    }
  } else
    modalElememt = document.querySelector(`[data-controller="modals"].modal.show`);

  if (!modalElememt)
    return;

  return Stimulus.getControllerForElementAndIdentifier(modalElememt, 'modals');
};

window.closeModal = function(modalId) {
  const controller = getOpenedModal(modalId);

  if (controller)
    controller.closeModal();
};
