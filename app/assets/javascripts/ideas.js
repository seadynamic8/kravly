
(function ($) {
  'use strict';

  function Wizard(form, steps_map) {
    this.$form = form;
    this.$progessBar = $(".idea-new-progress-bar").find(".icon");
    this.idPrefix = "#idea-new-";
    this.steps_map = steps_map;
    this.stateAnchorMap = {};


    this.stateAnchorMap.page = "pitch";
    // this.changeAnchorPart({ page: "pitch" });

    this.onHashchange();

    this.nextListener();
    this.prevListener();
    
    return this.$form;
  }

  Wizard.prototype.nextListener = function() {
    var self = this;

    self.$form.on('click', '.next-button', function (event) {
      self.goToNextStep.call(self, event);
    });

    self.$form.on('keydown', function(event) {
      if ( event.keyCode == 13) {  // Enter Key
        self.goToNextStep.call(self, event);
      }
    });
  };

  Wizard.prototype.prevListener = function () {
    var self = this;

    self.$form.on('click', '.prev-button', function(event) {
      event.preventDefault();

      self.goToPrevStep();
    });
  };

  Wizard.prototype.goToNextStep = function (event) {
    var currentStepIndex, nextStep;

    event.preventDefault();

    // disable validate hidden fields
    this.$form.validate().settings.ignore = ':disabled,:hidden';

    // validate
    if (this.$form.valid()) {

      // if not last step
      // if ($(element).parents('#idea-new-media').length == 0) {
        currentStepIndex = this.steps_map.indexOf( this.stateAnchorMap.page );
        nextStep         = this.steps_map[ currentStepIndex + 1 ];

        this.changeAnchorPart({ page: nextStep });
      // }
      // else { // if last step, submit form
      //   this.$form.submit();
      //   $(window).off('hashchange');
      // }
    }
  };

  Wizard.prototype.goToPrevStep = function() {
    var currentStepIndex = this.steps_map.indexOf( this.stateAnchorMap.page ),
        prevStep         = this.steps_map[currentStepIndex - 1];

    this.changeAnchorPart({ page: prevStep });
  };

  Wizard.prototype.goToStep = function( currentStep, targetStep ) {
    var currentStepIndex = this.steps_map.indexOf(currentStep),
        targetStepIndex  = this.steps_map.indexOf(targetStep);

    this.$form.find('.page').hide();

    // if targetStep is next step
    if ( currentStepIndex < targetStepIndex ) {
      
      // update progress bar class
      this.$progessBar.eq(this.stepsCount).removeClass('active');
      this.$progessBar.eq(this.stepsCount).addClass('finished');
      this.$progessBar.eq(this.stepsCount + 1).addClass('active');
    }
    // if targetStep is prev step
    else if ( targetStepIndex < currentStepIndex ) {

      // Remove error styles before going back.
      this.$form.find('label.error').remove();
      this.$form.find('.error').removeClass('error');

      // update progress bar class
      this.$progessBar.eq(this.stepsCount).removeClass('active');
      this.$progessBar.eq(this.stepsCount - 1).removeClass('finished');
      this.$progessBar.eq(this.stepsCount - 1).addClass('active');
    }
    else { // targetStep is the same step
      return false;
    }

    this.$form.find(this.idPrefix + targetStep).show();

    return true;
  };

  Wizard.prototype.copyAnchorMap = function () {
    return $.extend( true, {}, this.stateAnchorMap );
  };

  Wizard.prototype.changeAnchorPart = function ( arg_map ) {
    var
      anchor_map_revise = this.copyAnchorMap(),
      bool_return       = true,
      key_name, key_name_dep;

    // Begin merge changes into anchor map
    KEYVAL:
    for ( key_name in arg_map ) {
      if ( arg_map.hasOwnProperty( key_name )) {

        // skip dependent keys during iteration
        if ( key_name.indexOf( '_' ) === 0 ) { continue KEYVAL; }

        // update independent key value
        anchor_map_revise[key_name] = arg_map[key_name];

        //update matching dependent key
        key_name_dep = '_' + key_name;
        if ( arg_map[key_name_dep] ) {
          anchor_map_revise[key_name_dep] = arg_map[key_name_dep];
        }
        else {
          delete anchor_map_revise[key_name_dep];
          delete anchor_map_revise['_s' + key_name_dep];
        }
      }
    }
    // End merge changes into anchor map

    // Begin attempt to update URI; revert if not successful
    try {
      $.uriAnchor.setAnchor( anchor_map_revise );
    }
    catch( error ) {
      // replace URI with existing state
      $.uriAnchor.setAnchor( this.stateAnchorMap, null, true );
      bool_return = false;
    }
    // End attempt to update URI...

    return bool_return;
  };

  Wizard.prototype.onHashchange = function () {
    var self = this;

    $(window).on('hashchange', function( event ) {
      var
        _s_page_previous, _s_page_proposed, s_page_proposed,
        anchor_map_proposed,
        is_ok = true,
        anchor_map_previous = self.copyAnchorMap();

      if( String(document.location.pathname) === "/ideas/new" ) {
        // attempt to parse anchor
        try { anchor_map_proposed = $.uriAnchor.makeAnchorMap(); }
        catch ( error ) {
          $.uriAnchor.setAnchor( anchor_map_previous, null, true );
          return false;
        }
        self.stateAnchorMap = anchor_map_proposed;

        // convenience vars
        _s_page_previous = anchor_map_previous._s_page;
        _s_page_proposed = anchor_map_proposed._s_page;

        // Begin adjust page component if changed
        if ( ! anchor_map_previous
          || _s_page_previous !== _s_page_proposed ) {
          s_page_proposed = anchor_map_proposed.page;
          switch ( s_page_proposed ) {
            case 'pitch':
              is_ok = self.goToStep( anchor_map_previous.page, 'pitch' );
              break;
            case 'description':
              is_ok = self.goToStep( anchor_map_previous.page, 'description' );
              break;
            case 'media':
              is_ok = self.goToStep( anchor_map_previous.page, 'media' );
              break;
            default:
              self.goToStep( 'pitch' );
              delete anchor_map_proposed.page;
              $.uriAnchor.setAnchor( anchor_map_proposed, null, true );
          }
        }
        // End adjust page component if changed

        // Begin revert anchor if slider chnage denied
        if ( ! is_ok ) {
          if ( anchor_map_previous ) {
            $.uriAnchor.setAnchor( anchor_map_previous, null, true );
            self.stateAnchorMap = anchor_map_previous;
          }
          else {
            delete anchor_map_proposed.page;
            $.uriAnchor.setAnchor( anchor_map_proposed, null, true );
          }
        }
        // End revert anchor if slider change denied
      }
    });

    return false;
  };

  $(document).ready(function () {
    var
      anchor_schema_map = {
        page: {
          pitch: true,
          description: true,
          media: true
        },

      },
      steps_map = [
        "pitch",
        "description",
        "media"
      ],
      wizard;

    $.uriAnchor.configModule({
      schema_map: anchor_schema_map
    });

    wizard = new Wizard($('#idea-new-form'), steps_map);


    // Validation 
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


    // Character Counter
    $('#idea_title').characterCounter({
      limit: 45,
      counterFormat: '%1 characters left',
      // counterExceededCssClass: 'error'
      onExceed: function() {
        $('#idea_title').addClass('error');
      },
      onDeceed: function () {
        $('#idea_title').removeClass('error');
      }
    });
      
  });

})(jQuery);

