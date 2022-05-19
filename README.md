# Isoxya plugin Crawler HTML

Isoxya plugin Crawler HTML provides a core run loop for the crawling engine, parsing each page as static HTML, and extracting request metadata and outbound URLs. It is a plugin for [Isoxya](https://www.isoxya.com/) web crawler.

https://hub.docker.com/r/tiredpixel/isoxya-plugin-crawler-html  
https://github.com/tiredpixel/isoxya-plugin-crawler-html  


## Features

- links parsed
  `<a href="http://example.com">link</a>`

- header redirects extracted
  `Location`; HTTP Status `301`, `302`, `303`, `307`, `308`

- no-follow links respected
  `<a href="http://www.iana.org/domains/example" rel="nofollow">`

- base tags used for relative links
  `<base href="http://www.example.com/">`

- meta robots no-follow tags respected
  `<meta name="robots" content="nofollow">`

- header X-Robots-Tag no-follow respected
  `X-Robots-Tag: nofollow`


## Installation

Compile and boot locally:

```sh
docker compose up
```

Images are also published using the `latest` tag (for development), and version-specific tags (for production). Do *not* use a `latest` tag in production!


## Licence

Copyright © [Nic Williams](https://www.tiredpixel.com/). It is free software, released under the BSD 3-Clause licence, and may be redistributed under the terms specified in `LICENSE`.
