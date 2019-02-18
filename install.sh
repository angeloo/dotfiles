#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Make ZSH the default shell environment
chsh -s $(which zsh)

# Install PHP extensions with PECL
#pecl install imagick

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Install global Composer packages
#/usr/local/bin/composer global require laravel/installer laravel/spark-installer #laravel/valet

composer global require laravel/installer weprovide/valet-plus

#$HOME/.composer/vendor/bin/valet fix
#$HOME/.composer/vendor/bin/valet install

# Install Laravel Valet
#$HOME/.composer/vendor/bin/valet install

# Install global NPM packages
npm install --global yarn
yarn global add jshint
yarn global add puppeteer

# Create a Sites directory
# This is a default directory for macOS user accounts but doesn't comes pre-installed
mkdir $HOME/Sites

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/Code/dotfiles/.zshrc $HOME/.zshrc
source .zshrc

# Symlink the Mackup config file to the home directory
ln -s $HOME/Code/dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos