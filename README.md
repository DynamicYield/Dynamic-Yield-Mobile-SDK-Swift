# Dynamic Yield Swift SDK

## Overview

The **Dynamic Yield Swift SDK**  provides a complete interface to our Experience API that covers all major implementation aspects, including tracking pageviews, assigning targeted experiences, and tracking clicks and events.

## Documentation & Resources

For detailed implementation guides, SDK references, and troubleshooting, refer to the following resources:

- [Implement Mobile SDKs on Your App](https://dy.dev/docs/implement-mobile-sdk)
- [Swift SDK Documentation](https://dy.dev/docs/swift)
- [Release notes](https://github.com/DynamicYield/Dynamic-Yield-Mobile-SDK-Swift/releases)

## Installation prerequisites

| OS    | Minimum Version | Minimum Build Environment |
| ----- | --------------- | :------------------------ |
| iOS   | 14              | swift-tools-version: 5.9  |
| macOS | 12              | swift-tools-version: 5.9  |

## Install the Swift SDK

To install the Dynamic Yield iOS SDK using Swift Package Manager (SPM) in Xcode, do the following:

1. Open Xcode and navigate to your project.
2. Go to **Package Dependencies** in the project settings.
3. Click **"+"** to add a new package.
4. In the search bar, insert the repository URL: `https://github.com/DynamicYield/Dynamic-Yield-Mobile-SDK-Swift`.
5. Click **Add Package**.
6. Select the relevant target and click **Add Package** to complete the installation.

You're all set! The Dynamic Yield SDK should now be integrated into your project.

> **Note:** The Swift SDK doesn't support Obj-C apps.

## Set up app permissions for network access

The permission is granted by default.
