function() {    
  var env = karate.env;
  if (!env) {
    env = 'dev';
  }

  var config = {
    env: env,
    baseURL: karate.properties["mock.server.url"]
  }

  karate.log('karate.env=', env);
  karate.log('baseULR=', env);

  return config;
}