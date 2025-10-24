Backing up a DDEV Drupal site using Git primarily involves committing your codebase and configuration, and separately handling the database.
1. Version Control the Codebase and Configuration:
Initialize Git: If not already done, initialize a Git repository in your project's root directory.
Code

    git init
Add .ddev directory: Include the .ddev directory in your Git repository. This folder contains your DDEV project's configuration, which is essential for recreating the environment.
Add other project files: Add all your Drupal codebase, custom modules, themes, and configuration files (excluding sensitive data and generated files that should be ignored).
Create a .gitignore file: Exclude files that are not part of your version-controlled codebase, such as:
sites/*/files (for user-uploaded files)
vendor/ (Composer dependencies, which should be managed via composer.json and composer.lock)
web/core/ (if using Composer to manage Drupal core)
drush/ (if managing Drush separately)
Any local development specific files or directories not meant for production.
Commit changes: Regularly commit your changes to Git.
Code

    git add .
    git commit -m "Initial commit of Drupal codebase and DDEV config"
Push to a remote repository: Push your local repository to a remote Git hosting service (e.g., GitHub, GitLab, Bitbucket).
Code

    git remote add origin <remote_repository_url>
    git push -u origin main
2. Backup the Database:
Export the database: Use DDEV's command-line tools to export your Drupal database.
Code

    ddev export-db --file=database_backup.sql.gz
This command creates a gzipped SQL dump of your database.
Store the database backup: While you could add the database dump to Git, it's generally not recommended for large databases or frequent changes, as it bloats the repository history. Instead, store these backups in a secure, separate location, such as cloud storage, a network drive, or a dedicated backup solution.
Restoring the Site:
Clone the Git repository.
Code

    git clone <remote_repository_url>
Start DDEV.
Code

    ddev start
Import the database: Copy your database_backup.sql.gz file into your DDEV project directory and import it.
Code

    ddev import-db --file=database_backup.sql.gz
Install Composer dependencies.
Code

    ddev composer install
Clear caches and run database updates.
Code

    ddev drush cr
    ddev drush updb
