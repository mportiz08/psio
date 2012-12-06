Psio.slug = (resource) ->
  resource.toLowerCase()
          .replace(/\s+/g, '-')     # Replace spaces with -
          .replace(/[^\w\-]+/g, '') # Remove all non-word chars
          .replace(/\-\-+/g, '-')   # Replace multiple - with single -
          .replace(/^-+/, '')       # Trim - from start of text
          .replace(/-+$/, '')       # Trim - from end of text

Psio.urlEncode = (resource) ->
  encodeURIComponent(resource)

Psio.urlDecode = (resource) ->
  decodeURIComponent(resource)

progressBar = (percent) ->
  html = """
  <div class="progress progress-info progress-striped active">
    <div class="bar" style="width: #{percent}%"></div>
  </div>
  """
  new Handlebars.SafeString(html)

Handlebars.registerHelper 'progressBar', progressBar
