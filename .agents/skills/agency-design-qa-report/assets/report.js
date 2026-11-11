(function () {
  var sel = { flow: 'all', v: 'all' };
  var cards = [].slice.call(document.querySelectorAll('.card'));
  function apply() {
    var n = 0;
    cards.forEach(function (c) {
      var show = (sel.flow === 'all' || c.dataset.flow === sel.flow) && (sel.v === 'all' || c.dataset.v === sel.v);
      c.hidden = !show;
      if (show) n++;
    });
    document.getElementById('shown').textContent = n;
    document.getElementById('none').hidden = n > 0;
  }
  document.querySelectorAll('.chip').forEach(function (b) {
    b.addEventListener('click', function () {
      var f = b.dataset.f;
      sel[f] = b.dataset.val;
      document.querySelectorAll('.chip[data-f="' + f + '"]').forEach(function (o) {
        var on = o === b;
        o.classList.toggle('on', on);
        o.setAttribute('aria-pressed', on ? 'true' : 'false');
      });
      apply();
    });
  });

  // An index link must always land on its card, even when filters hide it.
  document.querySelectorAll('.ix').forEach(function (a) {
    a.addEventListener('click', function () {
      sel = { flow: 'all', v: 'all' };
      document.querySelectorAll('.chip').forEach(function (o) {
        var on = o.dataset.val === 'all';
        o.classList.toggle('on', on);
        o.setAttribute('aria-pressed', on ? 'true' : 'false');
      });
      apply();
    });
  });

  var lb = document.getElementById('lb'), lbi = document.getElementById('lbi'), lbc = document.getElementById('lbc');
  document.querySelectorAll('.zoom').forEach(function (b) {
    b.addEventListener('click', function () {
      var i = b.querySelector('img');
      lbi.src = i.src;
      lbi.alt = i.alt;
      lbc.textContent = i.alt;
      lb.showModal();
    });
  });
  document.getElementById('lbx').addEventListener('click', function () { lb.close(); });
  lb.addEventListener('click', function (e) { if (e.target === lb) lb.close(); });

  document.querySelectorAll('.ovbtn').forEach(function (b, idx) {
    b.addEventListener('click', function () {
      var card = b.closest('.card'), shots = card.querySelector('.shots'), cur = card.querySelector('.ovwrap');
      if (cur) {
        cur.remove();
        shots.hidden = false;
        b.setAttribute('aria-pressed', 'false');
        return;
      }
      var imgs = shots.querySelectorAll('img');
      var w = document.createElement('div');
      w.className = 'ovwrap';
      w.innerHTML = '<p>Left of the line: Figma V1. Right: app. Tops are aligned, and status bars will differ.</p><div class="ovl"><img class="base" alt=""><img class="top" alt=""></div><label><span hidden>Divider position</span><input type="range" min="0" max="100" value="50" id="ov' + idx + '"></label>';
      w.querySelector('.base').src = imgs[1].src;
      w.querySelector('.base').alt = imgs[1].alt;
      w.querySelector('.top').src = imgs[0].src;
      w.querySelector('.top').alt = imgs[0].alt;
      var o = w.querySelector('.ovl');
      w.querySelector('input').addEventListener('input', function (e) { o.style.setProperty('--x', e.target.value + '%'); });
      shots.hidden = true;
      shots.parentNode.insertBefore(w, shots);
      b.setAttribute('aria-pressed', 'true');
    });
  });
})();
