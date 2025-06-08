document.addEventListener('DOMContentLoaded', function() {
  const container = document.getElementById('flash-messages');
  const flashMessagesDisappearedAfter = container?.dataset.disappearAfter
    ? parseInt(container.dataset.disappearAfter, 10)
    : 5000;

  setTimeout(function() {
    document.querySelectorAll('[id^="flash-message-"]').forEach(function(el) {
      el.style.opacity = '0';
      setTimeout(() => el.style.display = 'none', 500);
    });
  }, flashMessagesDisappearedAfter);
});

window.closeFlash = function(idx) {
  var el = document.getElementById('flash-message-' + idx);
  if (el) {
    el.style.opacity = '0';
    setTimeout(function() { el.style.display = 'none'; }, 500);
  }
};
