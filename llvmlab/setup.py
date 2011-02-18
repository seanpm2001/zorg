import llvmlab
import os

from setuptools import setup, find_packages

# setuptools expects to be invoked from within the directory of setup.py, but it
# is nice to allow:
#   python path/to/setup.py install
# to work (for scripts, etc.)
os.chdir(os.path.dirname(os.path.abspath(__file__)))

setup(
    name = "llvmlab",
    version = llvmlab.__version__,

    author = llvmlab.__author__,
    author_email = llvmlab.__email__,
    url = 'http://lab.llvm.org',
    license = 'BSD',

    description = "lab.llvm.org Web App",
    keywords = 'web testing performance development llvm',

    classifiers=[
        'Development Status :: 1 - Planning',
        'Environment :: Web Environment',
        'Intended Audience :: Developers',
        ('License :: OSI Approved :: '
         'University of Illinois/NCSA Open Source License'),
        'Natural Language :: English',
        'Operating System :: OS Independent',
        'Progamming Language :: Python',
        'Topic :: Software Development :: Quality Assurance',
        'Topic :: Software Development :: Testing',
        ],

    zip_safe = False,

    packages = find_packages(),

    install_requires=['Flask'],
)
