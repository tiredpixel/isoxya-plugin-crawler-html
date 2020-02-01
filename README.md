# Isoxya plugin: Crawler HTML (Haskell)

[Isoxya plugin: Crawler HTML](https://github.com/pavouk-0/isoxya-plugin-crawler-html-hs) is an Isoxya plugin providing HTML page crawling to SEO and other internet-related data-processing activities. Using this in combination with the proprietary Isoxya engine, it's possible to crawl entire websites efficiently, even if they have millions of pages, and process them in myriad ways, depending on which plugins it's combined with.

[Isoxya](https://www.pavouk.tech/isoxya/) is a web crawler & data processing system. It is designed as a next-generation web crawler, scalable for large sites (millions of pages), cost-effective for tiny sites (1+ pages), offering flexible data processing using multi-industry plugins, delivering results via data streaming to multiple storage backends. It is magicked via a REST API using JSON.


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

We've tried to make this document clear and accessible. If you have any feedback about how we could improve it, or if there's any part of it you'd like to discuss or clarify, we'd love to hear from you. Our contact details are:

Pavouk OÜ | [https://www.pavouk.tech/](https://www.pavouk.tech/) | [en@pavouk.tech](mailto:en@pavouk.tech)


## Licence

Copyright © 2019-2020 [Pavouk OÜ](https://www.pavouk.tech/). It is free software, released under the BSD3 licence, and may be redistributed under the terms specified in `LICENSE`.
