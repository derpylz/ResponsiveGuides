HTMLWidgets.widget({

  name: 'ResponsiveGuides',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        let id = el.id;
        let guideDiv = document.createElement('div');
        guideDiv.id = 'guideDiv-' + id;
        guideDiv.className = 'ResponsiveGuides___guideDiv';
        guideDiv.classList.add(x.direction);
        if (x.scale == 'discrete') {
          breaks = x.breaks;
          colors = x.colors;
          for (let i = 0; i < breaks.length; i++) {
            let guide = document.createElement('div');
            guide.className = 'ResponsiveGuides___guide';
            let colorBox = document.createElement('div');
            colorBox.className = 'ResponsiveGuides___colorBox';
            colorBox.style.backgroundColor = colors[i];
            guide.appendChild(colorBox);
            let label = document.createElement('div');
            label.className = 'ResponsiveGuides___label';
            label.innerHTML = breaks[i];
            if (breaks[i] == x.focused) {
              guide.classList.add('focused');
              if (chroma(colors[i]).luminance() < 0.5) {
                label.style.color = 'white';
              }
            }
            guide.appendChild(label);
            guideDiv.appendChild(guide);
          }
          el.appendChild(guideDiv);
        }

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
