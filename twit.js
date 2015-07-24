if (Meteor.isClient) {
  // counter starts at 0
  Session.setDefault('counter', 0);

  Template.hello.helpers({
    counter: function () {
      return Session.get('counter');
    }
  });

  Template.hello.events({
    'click button': function () {
      // increment the counter when button is clicked
      Session.set('counter', Session.get('counter') + 1);
    }
  });
}

if (Meteor.isServer) {
  Meteor.startup(function () {
    // code to run on server at startup

    var Twit = Meteor.npmRequire('twit');

    var T = new Twit(Meteor.settings.twitterKeys);

    T.get(
      'statuses/user_timeline', {
        screen_name: 'derrybirkett',
        count: 3
      },
      function(err, data,response) {
        console.log(data);
      }
    );


  });
}
