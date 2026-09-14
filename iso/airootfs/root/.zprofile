# Arch Rice autoload (zsh login shells — root's default shell on releng).
# Mirrors .bash_profile: launch the rice loader exactly once on tty1.
if [ -z "${ARCH_RICE_LOADED:-}" ] && [ "$(tty 2>/dev/null)" = "/dev/tty1" ] && [ ! -e /tmp/.arch-rice-loaded ]; then
  export ARCH_RICE_LOADED=1
  touch /tmp/.arch-rice-loaded
  /usr/local/bin/arch-rice-loader.sh
fi
