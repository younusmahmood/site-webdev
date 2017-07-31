// Gulp tasks related to updating the pubspec version of angular & sdk
'use strict';

module.exports = function (gulp, plugins, config) {

  const EXAMPLES_PATH = config.EXAMPLES_PATH;
  const path = plugins.path;
  const replace = plugins.replace;

  gulp.task('update-pubspec', ['update-ng-vers', 'update-sdk-vers']);

  //---------------------------------------------------------------------------
  // Updating SDK version

  const SDK_VERS = '>=1.24.0 <2.0.0';

  gulp.task('update-sdk-vers', ['update-ng-vers'], (cb) => {
    const baseDir = path.resolve(EXAMPLES_PATH, '..');
    return gulp.src([
      `${baseDir}/**/pubspec.yaml`,
      `!${baseDir}/**/.pub/**`,
    ]) // , { base: baseDir }
      .pipe(replace(/^(\s+sdk): ['"][^'"]+['"]/m, `$1: '${SDK_VERS}'`))
      .pipe(gulp.dest(baseDir));
  });

  //---------------------------------------------------------------------------
  // Updating ACX and NG versions

  const ACX_VERS = `^${process.env.ACX_RELEASE.replace(/^v/, '')}`;
  const NG_VERS = `^${process.env.NG_RELEASE}`;
  const NG_TEST_VERS = `^${process.env.NG_TEST_RELEASE}`;

  const depOvr = 'dependency_overrides:\n' +
    '  angular:\n' +
    '    git: https://github.com/dart-lang/angular.git\n';
  const depOvr2 = 'git:\n' +
    '      url: https://github.com/dart-lang/angular.git\n' +
    '      ref: 3.0.0-alpha+1\n';
  const depOvr3 = 'dependency_overrides:\n' +
    `  angular:\n    ${depOvr2}\n`;

  gulp.task('update-ng-vers', [
    '_update-acx-vers', '_update-ng-vers',
    '_remove_platform_entries',
    '_remove_dep_overrides']);

  gulp.task('_update-acx-vers', (cb) => {
    const baseDir = path.resolve(EXAMPLES_PATH, '..');
    return gulp.src([
      `${baseDir}/**/pubspec.yaml`,
      `!${baseDir}/**/.pub/**`,
    ]) // , { base: baseDir }
      .pipe(replace(/(^\s+angular?_components:) \S+$/m, `$1 ${ACX_VERS}`))
      .pipe(gulp.dest(baseDir));
  });

  gulp.task('_update-ng-vers', ['_update-acx-vers'], (cb) => {
    const baseDir = path.resolve(EXAMPLES_PATH, '..');
    return gulp.src([
      `${baseDir}/**/pubspec.yaml`,
      `!${baseDir}/**/.pub/**`,
    ]) // , { base: baseDir }
      .pipe(replace(/(^\s+angular:) \S+$/m, `$1 ${NG_VERS}`))
      .pipe(replace(/(^\s+angular_test:) \S+$/m, `$1 ${NG_TEST_VERS}`))
      .pipe(gulp.dest(baseDir));
  });

  gulp.task('_dep_overrides', ['_update-acx-vers', '_update-ng-vers'], (cb) => {
    const baseDir = path.resolve(EXAMPLES_PATH, '..');
    return gulp.src([
      `${baseDir}/**/pubspec.yaml`,
      `!${baseDir}/**/.pub/**`,
    ]) // , { base: baseDir }
      .pipe(replace(/\btransformers:/, `${depOvr}$&`))
      .pipe(gulp.dest(baseDir));
  });

  gulp.task('_dep_overrides2', ['_update-acx-vers', '_update-ng-vers'], (cb) => {
    const baseDir = path.resolve(EXAMPLES_PATH, '..');
    return gulp.src([
      `${baseDir}/**/pubspec.yaml`,
      `!${baseDir}/**/.pub/**`,
    ]) // , { base: baseDir }
      .pipe(replace('git: https://github.com/dart-lang/angular.git', `${depOvr2}`))
      .pipe(gulp.dest(baseDir));
  });

  gulp.task('_remove_dep_overrides', ['_update-acx-vers', '_update-ng-vers'], (cb) => {
    const baseDir = path.resolve(EXAMPLES_PATH, '..');
    return gulp.src([
      `${baseDir}/**/pubspec.yaml`,
      `!${baseDir}/**/.pub/**`,
    ]) // , { base: baseDir }
      .pipe(replace(depOvr3, ''))
      .pipe(gulp.dest(baseDir));
  });

  const platform_star = 
  `    platform_directives:
    - 'package:angular/common.dart#COMMON_DIRECTIVES'
    platform_pipes:
    - 'package:angular/common.dart#COMMON_PIPES'
`;

  gulp.task('_remove_platform_entries', ['_update-acx-vers', '_update-ng-vers'], (cb) => {
    const baseDir = path.resolve(EXAMPLES_PATH, '..');
    return gulp.src([
      `${baseDir}/**/pubspec.yaml`,
      `!${baseDir}/**/.pub/**`,
    ]) // , { base: baseDir }
      .pipe(replace(platform_star, ''))
      .pipe(gulp.dest(baseDir));
  });

};
