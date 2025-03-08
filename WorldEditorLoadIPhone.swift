                    // Text input field
                    ZStack(alignment: .leading) {
                        if !isFocused && worldName.isEmpty {
                            Text("Name Your World")
                                .font(.custom("Papyrus", size: isIPhoneSE ? 20 : 24))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        TextField("", text: $worldName)
                            .font(.custom("Papyrus", size: isIPhoneSE ? 20 : 24))
                            .multilineTextAlignment(.leading)
                            .textFieldStyle(PlainTextFieldStyle())
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .tint(.white)
                            .focused($isFocused)
                    }
                    .offset(x: isIPhoneSE ? 200 : 285, y: isIPhoneSE ? -26 : -26) 

            // Popup overlay
            if showCreateWorldPopup {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                
                ZStack {
                    Image(isIPhoneSE ? "createWorldPopupSE" : "createWorldPopup")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: isIPhoneSE ? 455 : 683)
                    
                    // Text input field
                    ZStack(alignment: .leading) {
                        if !isFocused && worldName.isEmpty {
                            Text("Name Your World")
                                .font(.custom("Papyrus", size: isIPhoneSE ? 20 : 24))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        TextField("", text: $worldName)
                            .font(.custom("Papyrus", size: isIPhoneSE ? 20 : 24))
                            .multilineTextAlignment(.leading)
                            .textFieldStyle(PlainTextFieldStyle())
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .tint(.white)
                            .focused($isFocused)
                    }
                    .offset(x: isIPhoneSE ? 200 : 285, y: isIPhoneSE ? -26 : -26)
                    
                    // Buttons
                    HStack(spacing: isIPhoneSE ? -50 : -40) {
                        // Create button (left)
                        Button {
                            if worldManager.worldNameExists(worldName.trimmingCharacters(in: .whitespacesAndNewlines)) {
                                showDuplicateAlert = true
                            } else {
                                let newWorld = WorldEditorData(name: worldName.trimmingCharacters(in: .whitespacesAndNewlines))
                                worldManager.saveWorld(newWorld)
                                worldName = ""
                                showCreateWorldPopup = false
                            }
                        } label: {
                            ZStack {
                                Image("worldEditorLoadPopupButton")
                                    .frame(width: isIPhoneSE ? 455/2 : 683/3)
                                
                                Text("Create")
                                    .font(.custom("Papyrus", size: isIPhoneSE ? 20 : 24))
                                    .foregroundColor(Color(hex: "f29412"))
                            }
                        }
                        .disabled(worldName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        
                        // Cancel button (right)
                        Button {
                            worldName = ""
                            showCreateWorldPopup = false
                        } label: {
                            ZStack {
                                Image("worldEditorLoadPopupButton")
                                    .frame(width: isIPhoneSE ? 455/2 : 683/3)
                                
                                Text("Cancel")
                                    .font(.custom("Papyrus", size: isIPhoneSE ? 20 : 24))
                                    .foregroundColor(Color(hex: "f29412"))
                            }
                        }
                    }
                    .offset(y: isIPhoneSE ? 100 : 100)
                }
                .ignoresSafeArea(.keyboard)
                
                // Add alert for duplicate names
                .alert("World Already Exists", isPresented: $showDuplicateAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("A world with this name already exists. Please choose a different name.")
                }
            } 