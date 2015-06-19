var path              = require('path');
var nib               = require('nib');
var ExtractTextPlugin = require('extract-text-webpack-plugin');
var HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  entry: {torch: 'App'},
  module: {
    loaders: [
      {test: /\.coffee$/, loader: 'coffee-loader'},
      {test: /\.styl$/,   loader: ExtractTextPlugin.extract('style-loader', 'css-loader!stylus-loader')},
      {test: /assets/,    loader: 'url-loader?limit=20000&name=static/[name].[ext]'},
    ]
  },
  output: {
    path: 'dist',
    filename: 'torch-[hash].js',
    hash: true
  },
  plugins: [
    new ExtractTextPlugin('[name]-[hash].css'),
    new HtmlWebpackPlugin({
      title: 'TaskTorch',
      filename: 'index.html',
      template: 'assets/index.html',
      favicon: 'assets/favicon.ico',
      minify: true
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
