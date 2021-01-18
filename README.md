# Isoxya plugin: Crawler HTML

[Isoxya plugin: Crawler HTML](https://github.com/isoxya/isoxya-plugin-crawler-html) is an open-source (BSD 3-Clause) processor plugin for [Isoxya](https://www.isoxya.com/) web crawler. This plugin uses Isoxya 2 JSON interfaces to provide a core run loop for the crawling engine, receiving data for each page post-request, parsing it as static HTML, constructing URL metadata, and responding with a set of outbound URLs.

Since Isoxya supports both processor and streamer plugins using the Isoxya interfaces, it's not actually necessary to use this plugin at all, opening up the possibility of more complex usages such as extracting data from individual pages rather than actually crawling, or writing an alternative run loop altogether.


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


## Blessing

May you find peace, and help others to do likewise.


## Contact

[tiredpixel.com](https://www.tiredpixel.com/) · [tp@tiredpixel.com](mailto:tp@tiredpixel.com)

LinkedIn: [in/nic-williams](https://www.linkedin.com/in/nic-williams/) · Twitter: [tiredpixel](https://twitter.com/tiredpixel) · GitHub: [tiredpixel](https://github.com/tiredpixel)


## Licence

Copyright © 2019-2021 [Nic Williams](https://www.tiredpixel.com/). It is free software, released under the BSD 3-Clause licence, and may be redistributed under the terms specified in `LICENSE`.
