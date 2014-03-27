
(function ($) {

  function Wizard(form, steps) {
    this.stepsCount = 0;
    this.$form = form;
    this.stepsArr = steps;

    $(this.stepsArr[0]).show();

    this.nextListener();
    this.prevListener();

    return this.$form;
  }

  Wizard.prototype.nextListener = function() {
    var self = this;
    self.$form.on('click', '.next-button', function(event) {
      event.preventDefault();

      // disable validate hidden fields
      self.$form.validate().settings.ignore = ':disabled,:hidden';

      // validate
      if (self.$form.valid()) {
        
        if (self.stepsCount !== self.stepsArr.length - 1) {
          self.goToNextStep();
        } else {
          self.$form.submit();
        }

        self.stepsCount++;
      }
    });
  };

  Wizard.prototype.prevListener = function () {
    var self = this;
    self.$form.on('click', '.prev-button', function(event) {
      var currentStepId = self.stepsArr[self.stepsCount],
      prevStepId = self.stepsArr[self.stepsCount - 1];

      event.preventDefault();

      // Remove error styles before going back.
      self.$form.find('label.error').remove();
      self.$form.find('.error').removeClass('error');

      $(currentStepId).hide();
      $( prevStepId).show();

      self.stepsCount--;
    });
  };

  Wizard.prototype.goToNextStep = function () {
    var currentStepId = this.stepsArr[this.stepsCount],
    nextStepId = this.stepsArr[this.stepsCount + 1];

    $(currentStepId).hide();
    $(nextStepId).show();
  };

  $(document).ready(function () {
    var steps = [
    "#idea-new-pitch",
    "#idea-new-description",
    "#idea-new-media"
    ]

    var wizard = new Wizard($('#idea-new-form'), steps);
    wizard.validate({
      errorPlacement: function (error, element) {
        element.before(error);
      },
      rules: {
        'idea[title]': {
          required: true,
          minlength: 5,
          maxlength: 45
        },
        'idea[board_id]': {
          required: true
        },
        'idea[content]': {
          required: true
        }
      }
    });
  });

})(jQuery); 

