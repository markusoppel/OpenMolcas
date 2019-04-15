#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Setup file for the pymolcas package.
"""

from __future__ import with_statement
from __future__ import absolute_import
from setuptools import setup, find_packages
from io import open  # pylint:disable=redefined-builtin

MAIN_PACKAGE = 'pymolcas_lib'
DESCRIPTION = "Python module for starting MOLCAS."
LICENSE = 'LGPLv2'
AUTHOR = 'Ignacio Fdez. Galván'
EMAIL = 'ignacio.fernandez@kemi.uu.se'
URL = 'https://gitlab.com/Molcas/OpenMolcas'
VERSION = '0.1.0'
INSTALL_REQUIRES = ['pyparsing']
KEYWORDS = ['quantum chemistry']

CLASSIFIERS = [
    'Development Status :: 2 - Pre-Alpha Development Status',
    'Environment :: Console',
    'Intended Audience :: Science/Research',
    'License :: OSI Approved :: GNU Lesser General Public License v2 (LGPLv2)',
    'Operating System :: Unix',
    'Operating System :: POSIX',
    'Operating System :: Microsoft :: Windows',
    'Natural Language :: English',
    'Programming Language :: Python',
    'Programming Language :: Python :: 3.5',
    'Programming Language :: Python :: 3.6',
    'Topic :: Scientific/Engineering :: Chemistry',
    'Topic :: Scientific/Engineering :: Physics']


def readme():
    '''Return the contents of the README.md file.'''
    with open('README') as freadme:
        return freadme.read()


def setup_package():
    setup(
        name=MAIN_PACKAGE,
        version=VERSION,
        url=URL,
        description=DESCRIPTION,
        author=AUTHOR,
        author_email=EMAIL,
        include_package_data=True,
        keywords=KEYWORDS,
        license=LICENSE,
        long_description=readme(),
        classifiers=CLASSIFIERS,
        packages=find_packages('src'),
        package_dir={'': 'src'},
        entry_points={'console_scripts': [
            'pewmolcas=pymolcas_lib:main', 'f=pymolcas_lib:f']},
        install_requires=INSTALL_REQUIRES,
    )


if __name__ == "__main__":
    setup_package()
