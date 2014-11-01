module.exports =
  packageName: 'letter-spacing'
  configDefaults:
    'letter-spacing': 0

  activate: (state) ->
    atom.workspaceView.eachEditorView (editorView) =>
      @setCssLetterSpacing(editorView, @getLetterSpacing())

      atom.config.observe "#{@packageName}.letter-spacing", (value) =>
        @setCssLetterSpacing(editorView, value)
        editorView.redraw()

  getLetterSpacing: ->
    value = atom.config.get("#{@packageName}.letter-spacing")
    floatValue = parseFloat(value)
    return floatValue unless isNaN(floatValue)
    return @configDefaults['letter-spacing']

  setCssLetterSpacing: (view, value) ->
    atom.workspace.increaseFontSize()
    view.css('letter-spacing', "#{value}px")
    atom.workspace.decreaseFontSize()
