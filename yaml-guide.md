# Quick YAML Guide

This guide is intended to provide enough information to effectively
edit the `*.yml` files containing our data.

## Introduction

YAML is a versatile file format that can be used for a variety of
data. In our case, we use each `*.yml` file as a list of service
objects, each with their own attributes.

## Service Objects

Services objects describe individual services. They each have a
number of attributes that may contain helpful information about the
service.

### Currently Implemented Attributes

Attribute          | Required | Cardinality
------------------ | -------- | -----------
`title`            | Yes      | Single Value
`description`      | Yes      | Single Value
`phone`            | No       | Single Value or List
`mailing_address`  | No       | Single Value or List
`physical_address` | No       | Single Value or List
`email`            | No       | Single Value

## YAML Syntax

### Indentation

Indentation is very important in YAML. It always happens in multiples
of two spaces. Indentation typically designates what entities are
children of other things. For example, the service objects are
children of the main list, and each service object has children
which are attributes of the service object.

### Lists

Lists are defined by creating entities beginning with hyphens.

```yaml
- This is the first list item.
- This is the second list item.
- This is the third list item.
```

### Attributes

Attributes are defined by creating entities in a `key: value` format.
It is my personal preference to align groups of values vertically,
but this is *not* a YAML requirement and nothing bad will happen
if you don't. It just looks nicer.

```yaml
first_thing:  I'm the first thing.
second_thing: I'm the second thing.
third_thing:  I'm the third thing.
```

### Multiline Text

Sometimes you want to enter text that is very long and it looks
awkward in the YAML file. There are two ways you can break it up.

For instance, look at this line of YAML:

```yaml
long_string: This is a really long string that is going to look awkward if I jam it all onto one line because you have to scroll over to read it.
```

It's really hard to read. When the system displays it on a web page,
it will look fine, but the problem is that it's hard to edit as YAML.

#### Folded Strings

Folding strings is the first way to break up this long line. You can
do this by placing a `>` character on the preceding line, and then
indenting a multi-line block of text underneath.

```yaml
folded_string: >
  This is also a really long string, but it looks much nicer in
  the YAML file. You can see the whole thing without scrolling over,
  and it still gets read as one contiguous piece without line breaks.
```

#### Literal Strings

The other way to break up these long strings is to use the literal
syntax. It is very similar to the folded syntax, with the important
distinction that line breaks are preserved. This could be useful for
things like addresses where the breaks are important. Place a `|`
character at the end of a line, and then indent a multi-line block
of text underneath.

```yaml
literal_string: |
  123 Main St.
  Suite 456
  Columbus, OH
```

### Comments

Sometimes it's useful to leave notes in the YAML file, or to
temporarily disable certain entities from being processed. This can
be achieved quite simply with comments. A single `#` character will
cause the YAML parser to ignore the remaining text on the same line.

```yaml
# this is a file about a park
name:         Fetch Park
location:     Beck Street # remember to look up exact address soon
dogs_allowed: Yes
```

### Blank Lines

Blank lines don't really do anything but can be useful to visually
separate entities in the YAML file for higher readability.

```yaml
robert:
  favorite_color: red

vasanth:
  favorite_color: green
```

## Putting It All Together

Now that you've learned about all of the basic components we will
use in our YAML files, let's check out how to put these things
together.

Let's create a list of objects, not dissimilar from the actual format
of our service YAML files. In this example, we will create a list of
pets.

```yaml
-
  name:  Samuel
  type:  fish
  color: red
  age:   1 months
  notes: >
    Samuel is very fond the castle I gave him for his birthday!
    I swear I saw him rearranging the decorations inside.
    How curious!
  nicknames:
    - redrum
    - scalez

-
  name:  Bethany
  type:  python
  color: green
  age:   2 years
  notes: >
    Bethany is introverted, but once she opens up she's a great
    conversationalist!
  nicknames:
    - stop i can't breathe
    - no i'm serious you're crushing my trachea

# -
#   name:  Christine
#   type:  bird
#   color: green
#   age:   18 months
#   notes: She flew away on Wednesday. :(
#   nicknames:
#     - squawk
```
