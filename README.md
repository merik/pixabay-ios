#  Pixabay
A single-view app that allows user to search images through Pixabay services.
<p>
<img src="/Screenshots/screenshot1.png" width="200">
<img src="/Screenshots/screenshot2.png" width="200">
<img src="/Screenshots/screenshot3.png" width="200">

# Notes
- Deployment target: iOS 11
- Pure Swift (no 3rd party libs/frameworks)
- MVVM
- Only display first 50 photos returned.
- No pagination
- Basic in-memory image cache

# Todos
- Use NSCache for image cache
- Unit Tests
- Handling Errors
- Use collectionview instead of tableview to display photos (display photos in grid-like on iPads)
- Remove usage of storyboard/xibs
- Load more when reaching end of tableview/collectionview
- Remove hard-coding values
