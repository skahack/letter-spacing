module.exports =
  packageName: 'letter-spacing'
  config:
    'letter-spacing':
      default: 0
      type: 'integer'

  activate: (state) ->
    atom.workspace.observeTextEditors (editor) =>
      editorView = atom.views.getView(editor)

      @setCssLetterSpacing(editorView, @getLetterSpacing())

      atom.config.observe "#{@packageName}.letter-spacing", (value) =>
        @setCssLetterSpacing(editorView, value)

  getLetterSpacing: ->
    value = atom.config.get("#{@packageName}.letter-spacing")
    floatValue = parseFloat(value)
    return floatValue unless isNaN(floatValue)
    return @configDefaults['letter-spacing']

  setCssLetterSpacing: (view, value) ->
    view.style.letterSpacing = "#{value}px"

  getWorkspace: ->
    return atom.views.getView(atom.workspace)
