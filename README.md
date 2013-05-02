# rodash ~ rOpenSci Dashboard

This app is: 

+ built on [Dashing](http://shopify.github.com/dashing), from [Shopify.com](Shopify.com). In their words, "Dashing is a Sinatra based framework that lets you build beautiful dashboards".
+ hosted on Heroku.

See the dashboard here [http://rodash.herokuapp.com/roapi](http://rodash.herokuapp.com/roapi).  You can move the tiles (or in their words, widgets) around - put them in new places, etc. Here's a screenshot:

![](https://raw.github.com/ropensci/rodash/master/assets/images/app_sshot.png)

## Instructions for modifying, pushing to Github/Heroku

### Modify

If you are part of rOpenSci core team, go ahead and push to master. Everyone else, please fork the repo, and send a pull request. 

See [the Dashing Github page](http://shopify.github.com/dashing) in general for ideas. They have some demo pages to get ideas [here](http://dashingdemo.herokuapp.com/sample) and [here](http://dashingdemo.herokuapp.com/sampletv).

Modify the 'roapi' app inside the /dashboards/ folder. 

##### Tiles
Each tile in the app is a 'widget'. Go to /jobs/filename.rb to edit a particular tile, or within that folder to add a new tile, etc. 

If you add a new tile you need to add a `<li>` element within the dashboard file (e.g., /dashboards/roapi.erb) for it to show up, like this:

```html
<li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
  <div data-id="orcid" data-view="Text" data-title="Orcid" style="background-color:#DCA121"></div>
</li>
```

##### Styling
Files of interest:

+ /assets/javascripts/application.coffee
+ /assets/stylesheets/application.scss

##### Other files of interest:

+ /config.ru (setting configuration settings)
+ Dashboards are in /dashboards/ (the default one is called roapi.erb)

##### Looking at changes locally

Go to the repo folder in terminal, and run `dashing start`, then point browser to [http://localhost:3030/](http://localhost:3030/)

### Push to GitHub/Heroku

#### Github

+ rOPenSci core people: As you normally would commit and push.
+ Others: fork rodash and submit a pull request

#### Heroku

This is only for those with push access to the app on Heroku, i.e., the rOpenSci core team. Everyone else, we will merge your pull request and push the changes to Heroku.

Now, we just need to bundle up the app, and push to Heroku.  If you didn't push to github, remember to add and commit files first, then do the below.

```
bundle install
git push heroku master
```  

### Look at new site at [http://rodash.herokuapp.com/roapi](http://rodash.herokuapp.com/roapi)