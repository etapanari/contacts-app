# README

**Dependencies**

Install all the gems required by runnin:

```
$ bundle install
```

**Audit GEM installation**

This project requires the installation of the [audited](https://github.com/collectiveidea/audited) gem to implement the Edits History feature.

For that please run the following commands to install the gem and start the DB migration:

```
$ rails generate audited:install
$ rake db:migrate
```
