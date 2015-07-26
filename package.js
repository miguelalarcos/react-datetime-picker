Package.describe({
  name: 'miguelalarcos:react-datetime-picker',
  version: '0.1.6',
  // Brief, one-line summary of the package.
  summary: 'A date-time picker for React',
  // URL to the Git repository containing the source code for this package.
  git: 'https://github.com/miguelalarcos/react-datetime-picker.git',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  //api.use('coffeescript');
  api.use('reactjs:react@0.2.4');
  api.use('jhartma:cjsx@2.4.1');
  api.use('momentjs:moment@2.10.3');
  api.use('benmgreene:moment-range@1.0.7');
  api.use('pagebakers:ionicons@2.0.1_1');
  api.addFiles('react-datetime-picker.css', 'client');
  api.addFiles('react-datetime-picker.cjsx', 'client');
  //api.export('changedatemx', 'client');
  //api.export('DateTimePicker', 'client');
  api.export('DTP', 'client');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('miguelalarcos:react-datetime-picker');
  api.addFiles('react-datetime-picker-tests.js');
});
