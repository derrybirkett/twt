if Meteor.isServer
  Meteor.startup ->
    Twit = Meteor.npmRequire('twit')
    T = new Twit(Meteor.settings.twitterKeys)

    Meteor.methods fetchTweets: (qty) ->
      T.get 'statuses/user_timeline', {
        screen_name: 'derrybirkett'
        count: 3
      }, (err, data, response) ->
        console.log data
        return data
      return data


if Meteor.isClient
  Tweets = new Meteor.Collection(null)
  Template.tweet.rendered = ->
    latest = Meteor.call "fetchTweets", 3, (error, results) ->
      if(error)
        console.log(error)
      else
        console.log(results.data)
        Tweets.insert tweet for tweet in results.data

  Template.tweet.helpers
    tweets: ->
      Tweets.find()
