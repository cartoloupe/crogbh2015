# crogbh2015
community resources online give back hack 2015

[categories and icons needed](notes/categories.md)

## Tutorials
[Quick YAML Guide](guides/yaml.md)
[Quick Markdown Guide](guides/markdown.md)

## links to relevant organizations
- [besa](http://www.givebesa.org/)
- [starhouse](http://www.osustarhouse.com/About/Mission-and-Vision.aspx)

# Time Line For January 1st, 2016

### complete
- [x] embed maps
- [x] icons
  - [bootstrap components](http://getbootstrap.com/components/)
- [x] [slack channel](https://onesourcecommunity.slack.com/messages/general/)
- [x] finish putting up some content

### by September 1
- [ ] implement ui issues

### by November 1
- [ ] add search
- [ ] accounts and user login / content management system

### by December 1
- [ ] analytics

### by January 1

### future
- [ ] reviews
- [ ] better hosting
- [ ] lifeline preload

## technical
### moving data from text files
#### the pipeline:
Word documents --> text files --> csv

- for `word documents` --> `text files`; we manually shape the data
- for `text files` --> `csv`; there is a rake task: `rake data:txt2csv`

sample text file: `data/services/legal.txt`
sample csv file: `data/services/legal.csv`

```
rake data:txt2csv  # from text to csv
rake data:csv2db   # inserts csv data into db
```
