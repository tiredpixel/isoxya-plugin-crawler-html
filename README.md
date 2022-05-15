# Isoxya plugin Crawler HTML

Isoxya plugin Crawler HTML provides a core run loop for the crawling engine, parsing each page as static HTML, and extracting request metadata and outbound URLs. It is a plugin for [Isoxya](https://www.isoxya.com/) web crawler.

https://hub.docker.com/r/isoxya/isoxya-plugin-crawler-html  
https://github.com/isoxya/isoxya-plugin-crawler-html  


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

Choose a stream: `stable` (recommended), `testing`, or `unstable`:

```sh
cd misc/streams/stable/
```

Boot the stack:

```sh
docker compose up
```


## Contact

[tp@tiredpixel.com](mailto:tp@tiredpixel.com) · [www.tiredpixel.com](https://www.tiredpixel.com/) · [www.isoxya.com](https://www.isoxya.com/)

LinkedIn: [in/nic-williams](https://www.linkedin.com/in/nic-williams/) · Twitter: [tiredpixel](https://twitter.com/tiredpixel/) · GitHub: [tiredpixel](https://github.com/tiredpixel)


## Licence

Copyright © [Nic Williams](https://www.tiredpixel.com/). It is free software, released under the BSD 3-Clause licence, and may be redistributed under the terms specified in `LICENSE`.
