
module.exports = (grunt) ->
  grunt.initConfig
    cnfg:
      paths:
        nodeModules: './node_modules'
        bower_components: './bower_components'

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

    shell:
      bower_install:
        command: 'bower install'

    clean:
      bower_components: ['<%= cnfg.paths.bower_components %>']
      npm_packages: ['<%= cnfg.paths.bower_components %>']


  grunt.registerTask 'build', 'Build all code',
                     ['coffee:all',
                      'concat:vendor',
                      'uglify:all',
                      'concat:third']

#  grunt.registerTask 'clean:all', 'delete ',
#                     ['coffee:all',
#                      'concat:vendor',
#                      'uglify:all',
#                      'concat:third']

  grunt.registerTask 'post_install', 'Install the package on an empty system',
                     ['shell:bower_install']




  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-contrib-clean'