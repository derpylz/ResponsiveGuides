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
        } else {
          let continuousGuide = document.createElement('div');
          continuousGuide.className = 'ResponsiveGuides___continuousGuide';
          let rampDiv = document.createElement('div');
          rampDiv.className = 'ResponsiveGuides___rampDiv';
          for (let i = 0; i < x.colors.length; i++) {
            let rampSegment = document.createElement('div');
            rampSegment.className = 'ResponsiveGuides___rampSegment';
            rampSegment.style.backgroundColor = x.colors[i];
            rampDiv.appendChild(rampSegment);
          }
          continuousGuide.appendChild(rampDiv);
          let rampLabelDiv = document.createElement('div');
          rampLabelDiv.className = 'ResponsiveGuides___rampLabelDiv';
          if (x.direction == "column") {
            rampLabelDiv.style.height = x.colors.length + 'px';
          } else {
            rampLabelDiv.style.width = x.colors.length + 'px';
          }
          for (let i = 0; i < x.breaks.length; i++) {
            let rampLabel = document.createElement('div');
            rampLabel.className = 'ResponsiveGuides___rampLabel';
            rampLabel.innerHTML = x.breaks[i];
            rampLabelDiv.appendChild(rampLabel);
          }
          continuousGuide.appendChild(rampLabelDiv);
          guideDiv.appendChild(continuousGuide);
        }
        el.appendChild(guideDiv);
      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
