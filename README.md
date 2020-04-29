# Isoxya plugin: Crawler HTML

[Isoxya plugin: Crawler HTML](https://github.com/pavouk-0/isoxya-plugin-crawler-html) is a plugin for [Isoxya](https://www.pavouk.tech/isoxya/)—Web Crawler & Data Processing System. Using this in combination with the proprietary crawling engine by [Pavouk](https://www.pavouk.tech/), it's possible to process websites with tens of millions of pages, and extract and transform that data in myriad ways.


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

Pavouk OÜ | [https://www.pavouk.tech/](https://www.pavouk.tech/) | [en@pavouk.tech](mailto:en@pavouk.tech)


## Licence

Copyright © 2019-2020 [Pavouk OÜ](https://www.pavouk.tech/). It is free software, released under the BSD3 licence, and may be redistributed under the terms specified in `LICENSE`.
