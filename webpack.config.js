var path              = require('path');
var nib               = require('nib');
var DefinePlugin      = require('webpack').DefinePlugin;
var ExtractTextPlugin = require('extract-text-webpack-plugin');
var HtmlPlugin        = require('html-webpack-plugin');

module.exports = {
  entry: {torch: 'App'},
  module: {
    loaders: [
      {test: /\.coffee$/, loader: 'coffee-loader'},
      {test: /\.styl$/,   loader: ExtractTextPlugin.extract('style-loader', 'css-loader!stylus-loader')},
      {test: /assets/,    loader: 'url-loader?limit=50000&name=static/[name].[ext]'},
    ]
  },
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: '[hash]/torch.js',
    hash: true
  },
  plugins: [
    new DefinePlugin({
      '__DEV__': process.env['NODE_ENV'] !== 'production'
    }),
    new ExtractTextPlugin('[hash]/[name].css'),
    new HtmlPlugin({
      title: 'TaskTorch',
      filename: 'index.html',
      template: 'assets/index-dev.html'
    })
  ],
  resolve: {
    extensions: ['', '.coffee', '.js'],
    modulesDirectories: ['./src', './assets', './style', 'node_modules']
  },
  stylus: {
    use: [nib()],
    import: ['~normalize.css/normalize.css', __dirname + '/src/Theme.styl', 'nib']
  }
};
