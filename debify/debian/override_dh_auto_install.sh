#!/bin/bash

source debian/vars.sh

set -x

export php_version=`echo "$scl" | perl -pe '$_ =~ s/^ea-php(\d)(\d)$/$1.$2/'`

echo "SCL :$scl:"
echo "PHP_VERSION :$php_version:\n";

# The module itself
install -d -m 755 $DEB_INSTALL_ROOT${php_extdir}
install -m 755 ioncube_loader_lin_${php_version}.so $DEB_INSTALL_ROOT${php_extdir}

# The ini snippet
install -d -m 755 $DEB_INSTALL_ROOT${php_inidir}
cat > $DEB_INSTALL_ROOT${php_inidir}/${inifile} <<EOF
; Enable v12 IonCube Loader extension module
zend_extension="${php_extdir}/ioncube_loader_lin_${php_version}.so"
EOF

mkdir -p ${DEB_INSTALL_ROOT}/opt/cpanel/$scl/root/usr/share/doc/${name}
cp LICENSE.txt ${DEB_INSTALL_ROOT}/opt/cpanel/$scl/root/usr/share/doc/${name}
cp README.txt ${DEB_INSTALL_ROOT}/opt/cpanel/$scl/root/usr/share/doc/${name}

echo "FILELIST"
find . -type f -print | sort


