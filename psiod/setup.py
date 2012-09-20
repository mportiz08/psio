from setuptools import setup
import psiod

setup(
  name='psiod',
  version=psiod.__version__,
  description=psiod.__doc__.strip(),
  author=psiod.__author__,
  license=psiod.__license__,
  packages=['psiod'],
  entry_points={
    'console_scripts': [
      'psiod = psiod.__main__:main'
    ]
  },
  install_requires=[
    'psutil>=0.6.1',
    'tornado>=2.3'
  ]
)
