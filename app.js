const express = require('express');
const app = express();

// Ensure proxy headers (like `X-Forwarded-Proto`) are respected.
app.set('trust proxy', true);

// Redirect non-SSL to SSL.
app.use((req, res, next) => {
  if (req.secure || req.hostname === 'localhost') {
    next();
  } else {
    res.redirect(`https://${req.hostname}${req.path}`);
  }
});

// Serve public site.
app.use(express.static('public'));

app.listen(process.env.PORT || 8080);
