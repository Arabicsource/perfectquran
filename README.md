# PerfectQuran

Bismillah ar-Rahman ar-Rahim

The Quran is a book that judges between the good and bad. [Quran 25:1](https://perfectquran.co/al-furqan). Therefore, by following its commands and abstaining from what it prohibits, we can adhere to the middle-path that was chosen for us by our Lord.

The PerfectQuran project has been around in a number of forms, however, the main goal of the project has always been to help facilitate learning the Quran as a means of benefit for Muslims and a way to keep them from following one of the many evil paths of extremism.

The evil of ISIS' theology and methodology cannot find a handhold in any heart where there is understanding of the Divine message of the Quran.

## Crons

```shell
0 * * * * cd ~/perfectquran/current && RAILS_ENV=production ~/.rvm/wrappers/ruby-2.4.1@perfectquran/bundle exec rails runner "TweetNextAyah.new.call"
```