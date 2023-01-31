/*
 * Copyright 2022 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: SettingsViewModel

    var body: some View {
        VStack {
            Form {
                Section {
                    Stepper("settings_dice_count_label \(viewModel.diceCount)", value: $viewModel.diceCount, in: 1...10)
                    Stepper("settings_side_count_label \(viewModel.sideCount)", value: $viewModel.sideCount, in: 3...100)
                    Toggle("settings_unique_numbers_label", isOn: $viewModel.uniqueRollsOnly)
                }

                Section {
                    Button("settings_save_button", action: {
                        viewModel.saveSettings()
                    }).disabled(!viewModel.isSettingsModified)
                }
            }
        }
    }
}
