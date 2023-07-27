# JSONB Union - Smart Combine PostgreSQL Extension

![JSONB Union Logo](https://your-domain.com/path/to/logo.png)

JSONB Union is a powerful PostgreSQL extension that allows you to smartly combine two JSONB objects in a way that preserves non-null values, merges arrays, recursively compares nested objects, and drops duplicates. This extension is designed to be used as both a standalone function and as an aggregation function with the `GROUP BY` clause.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
  - [Basic Usage](#basic-usage)
  - [Aggregation Usage](#aggregation-usage)
- [Examples](#examples)
  - [Example 1](#example-1)
  - [Example 2](#example-2)
- [Contributing](#contributing)
- [License](#license)

## Introduction

Working with JSONB data in PostgreSQL can be challenging when you need to merge objects in a way that intelligently handles conflicting values, nested structures, and duplicates. JSONB Union comes to the rescue by providing a simple yet powerful function that smartly combines two JSONB objects, catering to a wide range of scenarios.

## Features

- **Smart Merge**: JSONB Union handles conflicting non-null values by combining them into arrays, preserving both elements.
- **Recursive Comparison**: When encountering nested JSONB objects, JSONB Union will recursively compare their keys and merge them accordingly.
- **Duplicate Elimination**: If a field is an array in both objects, JSONB Union will merge and drop duplicates, ensuring unique elements in the resulting array.
- **Easy Integration**: The extension can be used as both a standalone function and an aggregation function with `GROUP BY`.
- **High Performance**: JSONB Union is optimized for performance, ensuring efficient operations on large datasets.
- **Fully Customizable**: As an open-source project, you can modify and adapt JSONB Union to suit your specific needs.

## Installation

To use JSONB Union, follow these simple steps to install the extension in your PostgreSQL database.

1. Clone the JSONB Union repository from GitHub.
2. Navigate to the project directory.

```bash
git clone https://github.com/your-username/jsonb-union.git
cd jsonb-union
```

3. Build and install the extension.

```bash
make
sudo make install
```

4. Ensure that the extension is properly loaded in your PostgreSQL database.

```sql
CREATE EXTENSION IF NOT EXISTS jsonb_union;
```

Congratulations! You have successfully installed JSONB Union in your PostgreSQL environment.

## Usage

### Basic Usage

JSONB Union can be used as a standalone function to combine two JSONB objects.

```sql
SELECT jsonb_union(
    '{"a": [1,2], "b": 2, "c": 3, "e": 5, "d": null}'::jsonb,
    '{"a": 2, "b": 2, "e": 6, "d": 7}'::jsonb
);
-- Output: {"a": [1, 2], "b": 2, "c": 3, "d": 7, "e": [5, 6]};
```

### Aggregation Usage

JSONB Union can also be used as an aggregation function with the `GROUP BY` clause.

```sql
SELECT jsonb_union_agg(json_field)
FROM your_table
GROUP BY group_column;
```

## Examples

### Example 1

Let's demonstrate JSONB Union's smart merging capability.

```sql
SELECT jsonb_union(
    '{"a": {"aa": 2, "ab": [2,3]}, "b": {"ba": 1}, "d": null}'::jsonb,
    '{"a": {"aa": 2, "ab": [1,2]}, "b": 2, "d": {"da": 1}, "e": 6}'::jsonb
);
-- Output: {"a": {"aa": 2, "ab": [1, 2, 3]}, "b": [2, {"ba": 1}], "d": {"da": 1}, "e": 6}
```

### Example 2

Now, let's use JSONB Union as an aggregation function.

```sql
SELECT jsonb_union_agg(json_field) FROM your_table GROUP BY group_column;
-- Output: Combined JSONB objects for each group.
```

## Contributing

We welcome contributions to JSONB Union! If you find a bug, have an enhancement suggestion, or want to add new features, please feel free to open an issue or submit a pull request. Together, we can make JSONB Union even better!

## License

JSONB Union is released under the MIT License. See [LICENSE](LICENSE) for more details.

---

We hope you find JSONB Union helpful in managing and merging your JSONB data in PostgreSQL. If you have any questions or need further assistance, don't hesitate to reach out to us.

Happy coding!

The JSONB Union Team
