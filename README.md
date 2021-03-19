# Isoxya web crawler plugin: Crawler HTML

[Isoxya web crawler plugin: Crawler HTML](https://github.com/isoxya/isoxya-plugin-crawler-html) is an open-source (BSD 3-Clause) processor plugin for [Isoxya](https://www.isoxya.com/) web crawler. This plugin provides a core run loop for the crawling engine, receiving data for each page post-request, parsing it as static HTML, constructing URL metadata, and responding with a set of outbound URLs. It can be used with [Isoxya web crawler Community Edition](https://github.com/isoxya/isoxya-ce) (Isoxya CE), a free and open-source (BSD 3-Clause) mini crawler, suitable for small crawls on a single computer.

Since Isoxya supports both processor and streamer plugins using the Isoxya interfaces, it's not actually necessary to use this plugin at all, opening up the possibility of more complex usages such as extracting data from individual pages rather than actually crawling, or writing an alternative run loop altogether.

Also available is [Isoxya web crawler Pro Edition](https://www.isoxya.com/) (Isoxya PE), a commercial and closed-source distributed crawler, suitable for small, large, and humongous crawls on high-availability clusters of multiple computers. Both editions utilise flexible [plugins](https://www.isoxya.com/plugins/), allowing numerous programming languages to be used to extend the core engine via JSON [interfaces](https://docs.isoxya.com/#interfaces). Plugins written for Isoxya CE should typically scale to Isoxya PE with minimal or no changes. More details and licences are available [on request](mailto:en@isoxya.com).


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


## Contact

[en@isoxya.com](mailto:en@isoxya.com) · [isoxya.com](https://www.isoxya.com/)

[tp@tiredpixel.com](mailto:tp@tiredpixel.com) · [tiredpixel.com](https://www.tiredpixel.com/)

LinkedIn: [in/nic-williams](https://www.linkedin.com/in/nic-williams/) · GitHub: [tiredpixel](https://github.com/tiredpixel)


## Licence

Copyright © 2019-2021 [Nic Williams](https://www.tiredpixel.com/). It is free software, released under the BSD 3-Clause licence, and may be redistributed under the terms specified in `LICENSE`.
