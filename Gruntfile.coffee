
module.exports = (grunt) ->
  grunt.initConfig

    pkg: grunt.file.readJSON('package.json')
    assets: grunt.file.readJSON('assets.json'),

    coffee:
      all:
        expand: true,
        cwd: 'source/coffee/',
        src: ['**/*.coffee'],
        dest: 'build/js/',
        ext: '.js'

    concat:
      options:
        separator: ';'
      third:
        files: [
          '<%= assets.main.third %>',
          '<%= assets.main.third_min %>'
        ]
      vendor:
        src: ['build/js/**/*.js']
        dest: 'public/js/vendor.js'

    uglify:
      all:
        files:
          'public/js/vendor.min.js': 'public/js/vendor.js'


  grunt.registerTask 'build', 'Build all code', () ->
    grunt.task.run 'coffee:all',
                   'concat:vendor',
                   'uglify:all',
                   'concat:third'

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'