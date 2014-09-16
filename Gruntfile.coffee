module.exports = (grunt) ->

  grunt.loadNpmTasks('grunt-browserify')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-sass')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.initConfig

    browserify:
      app:
        options:
          alias: ['react:react']
          browserifyOptions: {extensions: ['.coffee']}
          transform: ['coffeeify']
        files:
          'dist/torch.js': ['src/**/*.coffee']

    clean:
      app: ['dist']

    sass:
      app:
        files:
          'dist/torch.css': ['style/**/*.scss']

    copy:
      app:
        files: [{expand: true, cwd: 'assets', src: ['**'], dest: 'dist'}]

    watch:
      code:
        files: ['src/**/*.coffee']
        tasks: ['browserify:app']
        options: {spawn: false}
      style:
        files: ['style/**/*.scss']
        tasks: ['sass:app']
        options: {spawn: false}

  grunt.registerTask 'build', ['browserify', 'sass', 'copy']
  grunt.registerTask 'default', ['build']
