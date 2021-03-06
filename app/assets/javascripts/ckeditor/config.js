CKEDITOR.editorConfig = function( config ) {
	config.toolbarGroups = [
		{ name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
		{ name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
		{ name: 'editing', groups: [ 'find', 'selection', 'spellchecker', 'editing' ] },
		{ name: 'forms', groups: [ 'forms' ] },
		{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
		{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
		{ name: 'links', groups: [ 'links' ] },
		{ name: 'insert', groups: [ 'insert' ] },
		'/',
		'/',
		{ name: 'styles', groups: [ 'styles' ] },
		{ name: 'colors', groups: [ 'colors' ] },
		{ name: 'tools', groups: [ 'tools' ] },
		{ name: 'others', groups: [ 'others' ] },
		{ name: 'about', groups: [ 'about' ] }
	];
	console.log('hehe')
	config.removeButtons = 'Print,Preview,NewPage,Save,Templates,PasteFromWord,Scayt,Form,Checkbox,Radio,Textarea,TextField,Select,Button,ImageButton,HiddenField,SelectAll,Replace,Outdent,Indent,BidiLtr,BidiRtl,Language,Anchor,Flash,PageBreak,About,CreateDiv,CopyFormatting,RemoveFormat';
	config.filebrowserImageBrowseLinkUrl = "uploads/ckeditor/attachments/";
  config.filebrowserImageBrowseUrl = "uploads/ckeditor/attachments/";
  config.filebrowserImageUploadUrl = "uploads/ckeditor/attachments/";
};
