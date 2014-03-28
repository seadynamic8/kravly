CKEDITOR.editorConfig = function( config ) {

		//config.language = 'fr';
		config.uiColor = '#125d7e';

		config.toolbar = [
			{ name: 'document', items: [ 'Source' ] },
			{ name: 'clipboard', items: [ 'PasteFromWord' ] },
			{ name: 'clipboard', items: [ 'Undo', 'Redo' ] },
			{ name: 'insert', items: [ 'Image','Table','HorizontalRule','Smiley',
							'SpecialChar' ] },
			{ name: 'links', items : [ 'Link','Unlink','Anchor' ] },
			'/',
			{ name: 'paragraph', items: [ 'NumberedList','BulletedList','-','Outdent','Indent' ] },
			{ name: 'paragraph', items: [ 'Blockquote' ] },
			{ name: 'paragraph', items: [ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 
							'JustifyBlock' ] },
			'/',
			{ name: 'basicstyles', items: [ 'Bold', 'Italic', 'Underline', 'Strike' ] },
			{ name: 'styles', items: [ 'Format', 'Font', 'Size' ] },
			{ name: 'colors', items: [ 'TextColor', 'BGColor' ] },
		];

		//config.autoGrow_minHeight = 500;
		config.height = 500;
};