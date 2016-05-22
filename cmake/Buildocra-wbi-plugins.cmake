# CoDyCo
include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(ICUB QUIET)
find_or_build_package(yarpWholeBodyInterface QUIET)
find_or_build_package(qpOASES QUIET)


set(CODYCO_CMAKE_CACHE_ARGS_USER_DEFINED "")
if(${CODYCO_USES_URDFDOM})
    set(CODYCO_CMAKE_CACHE_ARGS_USER_DEFINED ${CODYCO_CMAKE_CACHE_ARGS_USER_DEFINED} -DCODYCO_USES_URDFDOM:BOOL=ON)
elseif()
    set(CODYCO_CMAKE_CACHE_ARGS_USER_DEFINED ${CODYCO_CMAKE_CACHE_ARGS_USER_DEFINED} -DCODYCO_USES_URDFDOM:BOOL=OFF)
endif()

if(${CODYCO_USES_WBI_TOOLBOX})
    set(CODYCO_CMAKE_CACHE_ARGS_USER_DEFINED ${CODYCO_CMAKE_CACHE_ARGS_USER_DEFINED} -DCODYCO_USES_WBI_TOOLBOX:BOOL=ON)
elseif()
    set(CODYCO_CMAKE_CACHE_ARGS_USER_DEFINED ${CODYCO_CMAKE_CACHE_ARGS_USER_DEFINED} -DCODYCO_USES_WBI_TOOLBOX:BOOL=OFF)
endif()

if(${CODYCO_TRAVIS_CI})
    set(CODYCO_CMAKE_CACHE_ARGS_USER_DEFINED ${CODYCO_CMAKE_CACHE_ARGS_USER_DEFINED} -DCODYCO_TRAVIS_CI:BOOL=ON)
elseif()
    set(CODYCO_CMAKE_CACHE_ARGS_USER_DEFINED ${CODYCO_CMAKE_CACHE_ARGS_USER_DEFINED} -DCODYCO_TRAVIS_CI:BOOL=OFF)
endif()

if(${CODYCO_ICUBWBI_USE_EXTERNAL_TORQUE_CONTROL})
    set(CODYCO_CMAKE_CACHE_ARGS_USER_DEFINED ${CODYCO_CMAKE_CACHE_ARGS_USER_DEFINED} -DCODYCO_ICUBWBI_USE_EXTERNAL_TORQUE_CONTROL:BOOL=ON)
elseif()
    set(CODYCO_CMAKE_CACHE_ARGS_USER_DEFINED ${CODYCO_CMAKE_CACHE_ARGS_USER_DEFINED} -DCODYCO_ICUBWBI_USE_EXTERNAL_TORQUE_CONTROL:BOOL=OFF)
endif()

ycm_ep_helper(EigenLgsm TYPE GIT
              STYLE GITHUB
              REPOSITORY ocra-recipes/eigen_lgsm.git
              TAG master
              COMPONENT libraries
              CMAKE_CACHE_ARGS ${CODYCO_CMAKE_CACHE_ARGS_USER_DEFINED})

ycm_ep_helper(ocra-recipes TYPE GIT
              STYLE GITHUB
              REPOSITORY ocra-recipes/ocra-recipes.git
              TAG master
              COMPONENT libraries
              CMAKE_CACHE_ARGS ${CODYCO_CMAKE_CACHE_ARGS_USER_DEFINED}
              DEPENDS YARP
                      qpOASES
                      EigenLgsm)

ycm_ep_helper(ocra-wbi-plugins TYPE GIT
              STYLE GITHUB
              REPOSITORY ocra-recipes/ocra-wbi-plugins.git
              TAG master
              COMPONENT main
              CMAKE_CACHE_ARGS ${CODYCO_CMAKE_CACHE_ARGS_USER_DEFINED}
              DEPENDS YARP
                      ICUB
                      iDynTree
                      wholeBodyInterface
                      yarpWholeBodyInterface
                      ocra-recipes
                      EigenLgsm)
