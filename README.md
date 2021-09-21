# PeriodDuration

This library introduces a rough equivalent of [Java's PeriodDuration](https://www.threeten.org/threeten-extra/apidocs/org.threeten.extra/org/threeten/extra/PeriodDuration.html), motivated by the lack of support for this standard in Foundation.

`PeriodDuration` is based off of a [previous library](https://github.com/treatwell/ISO8601PeriodDuration) I worked on, however it goes beyond simple serialization by introducing concrete types with full `Codable` support.
