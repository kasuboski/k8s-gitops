package josh

customresourcedefinition: "applicationsets.argoproj.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		labels: {
			"app.kubernetes.io/name":    "applicationsets.argoproj.io"
			"app.kubernetes.io/part-of": "argocd"
		}
		name: "applicationsets.argoproj.io"
	}
	spec: {
		group: "argoproj.io"
		names: {
			kind:     "ApplicationSet"
			listKind: "ApplicationSetList"
			plural:   "applicationsets"
			shortNames: [
				"appset",
				"appsets",
			]
			singular: "applicationset"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						properties: {
							generators: {
								items: {
									properties: {
										clusterDecisionResource: {
											properties: {
												configMapRef: type: "string"
												labelSelector: {
													properties: {
														matchExpressions: {
															items: {
																properties: {
																	key: type: "string"
																	operator: type: "string"
																	values: {
																		items: type: "string"
																		type: "array"
																	}
																}
																required: [
																	"key",
																	"operator",
																]
																type: "object"
															}
															type: "array"
														}
														matchLabels: {
															additionalProperties: type: "string"
															type: "object"
														}
													}
													type: "object"
												}
												name: type: "string"
												requeueAfterSeconds: {
													format: "int64"
													type:   "integer"
												}
												template: {
													properties: {
														metadata: {
															properties: {
																annotations: {
																	additionalProperties: type: "string"
																	type: "object"
																}
																finalizers: {
																	items: type: "string"
																	type: "array"
																}
																labels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
																name: type: "string"
																namespace: type: "string"
															}
															type: "object"
														}
														spec: {
															properties: {
																destination: {
																	properties: {
																		name: type: "string"
																		namespace: type: "string"
																		server: type: "string"
																	}
																	type: "object"
																}
																ignoreDifferences: {
																	items: {
																		properties: {
																			group: type: "string"
																			jqPathExpressions: {
																				items: type: "string"
																				type: "array"
																			}
																			jsonPointers: {
																				items: type: "string"
																				type: "array"
																			}
																			kind: type: "string"
																			managedFieldsManagers: {
																				items: type: "string"
																				type: "array"
																			}
																			name: type: "string"
																			namespace: type: "string"
																		}
																		required: ["kind"]
																		type: "object"
																	}
																	type: "array"
																}
																info: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																project: type: "string"
																revisionHistoryLimit: {
																	format: "int64"
																	type:   "integer"
																}
																source: {
																	properties: {
																		chart: type: "string"
																		directory: {
																			properties: {
																				exclude: type: "string"
																				include: type: "string"
																				jsonnet: {
																					properties: {
																						extVars: {
																							items: {
																								properties: {
																									code: type: "boolean"
																									name: type: "string"
																									value: type: "string"
																								}
																								required: [
																									"name",
																									"value",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																						libs: {
																							items: type: "string"
																							type: "array"
																						}
																						tlas: {
																							items: {
																								properties: {
																									code: type: "boolean"
																									name: type: "string"
																									value: type: "string"
																								}
																								required: [
																									"name",
																									"value",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																					}
																					type: "object"
																				}
																				recurse: type: "boolean"
																			}
																			type: "object"
																		}
																		helm: {
																			properties: {
																				fileParameters: {
																					items: {
																						properties: {
																							name: type: "string"
																							path: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																				ignoreMissingValueFiles: type: "boolean"
																				parameters: {
																					items: {
																						properties: {
																							forceString: type: "boolean"
																							name: type: "string"
																							value: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																				passCredentials: type: "boolean"
																				releaseName: type: "string"
																				skipCrds: type: "boolean"
																				valueFiles: {
																					items: type: "string"
																					type: "array"
																				}
																				values: type: "string"
																				version: type: "string"
																			}
																			type: "object"
																		}
																		kustomize: {
																			properties: {
																				commonAnnotations: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				commonLabels: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				forceCommonAnnotations: type: "boolean"
																				forceCommonLabels: type: "boolean"
																				images: {
																					items: type: "string"
																					type: "array"
																				}
																				namePrefix: type: "string"
																				nameSuffix: type: "string"
																				version: type: "string"
																			}
																			type: "object"
																		}
																		path: type: "string"
																		plugin: {
																			properties: {
																				env: {
																					items: {
																						properties: {
																							name: type: "string"
																							value: type: "string"
																						}
																						required: [
																							"name",
																							"value",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				name: type: "string"
																				parameters: {
																					items: {
																						properties: {
																							array: {
																								items: type: "string"
																								type: "array"
																							}
																							map: {
																								additionalProperties: type: "string"
																								type: "object"
																							}
																							name: type: "string"
																							string: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																			}
																			type: "object"
																		}
																		ref: type: "string"
																		repoURL: type: "string"
																		targetRevision: type: "string"
																	}
																	required: ["repoURL"]
																	type: "object"
																}
																sources: {
																	items: {
																		properties: {
																			chart: type: "string"
																			directory: {
																				properties: {
																					exclude: type: "string"
																					include: type: "string"
																					jsonnet: {
																						properties: {
																							extVars: {
																								items: {
																									properties: {
																										code: type: "boolean"
																										name: type: "string"
																										value: type: "string"
																									}
																									required: [
																										"name",
																										"value",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																							libs: {
																								items: type: "string"
																								type: "array"
																							}
																							tlas: {
																								items: {
																									properties: {
																										code: type: "boolean"
																										name: type: "string"
																										value: type: "string"
																									}
																									required: [
																										"name",
																										"value",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																						}
																						type: "object"
																					}
																					recurse: type: "boolean"
																				}
																				type: "object"
																			}
																			helm: {
																				properties: {
																					fileParameters: {
																						items: {
																							properties: {
																								name: type: "string"
																								path: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																					ignoreMissingValueFiles: type: "boolean"
																					parameters: {
																						items: {
																							properties: {
																								forceString: type: "boolean"
																								name: type: "string"
																								value: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																					passCredentials: type: "boolean"
																					releaseName: type: "string"
																					skipCrds: type: "boolean"
																					valueFiles: {
																						items: type: "string"
																						type: "array"
																					}
																					values: type: "string"
																					version: type: "string"
																				}
																				type: "object"
																			}
																			kustomize: {
																				properties: {
																					commonAnnotations: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					commonLabels: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					forceCommonAnnotations: type: "boolean"
																					forceCommonLabels: type: "boolean"
																					images: {
																						items: type: "string"
																						type: "array"
																					}
																					namePrefix: type: "string"
																					nameSuffix: type: "string"
																					version: type: "string"
																				}
																				type: "object"
																			}
																			path: type: "string"
																			plugin: {
																				properties: {
																					env: {
																						items: {
																							properties: {
																								name: type: "string"
																								value: type: "string"
																							}
																							required: [
																								"name",
																								"value",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					name: type: "string"
																					parameters: {
																						items: {
																							properties: {
																								array: {
																									items: type: "string"
																									type: "array"
																								}
																								map: {
																									additionalProperties: type: "string"
																									type: "object"
																								}
																								name: type: "string"
																								string: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																				}
																				type: "object"
																			}
																			ref: type: "string"
																			repoURL: type: "string"
																			targetRevision: type: "string"
																		}
																		required: ["repoURL"]
																		type: "object"
																	}
																	type: "array"
																}
																syncPolicy: {
																	properties: {
																		automated: {
																			properties: {
																				allowEmpty: type: "boolean"
																				prune: type: "boolean"
																				selfHeal: type: "boolean"
																			}
																			type: "object"
																		}
																		managedNamespaceMetadata: {
																			properties: {
																				annotations: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				labels: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																			}
																			type: "object"
																		}
																		retry: {
																			properties: {
																				backoff: {
																					properties: {
																						duration: type: "string"
																						factor: {
																							format: "int64"
																							type:   "integer"
																						}
																						maxDuration: type: "string"
																					}
																					type: "object"
																				}
																				limit: {
																					format: "int64"
																					type:   "integer"
																				}
																			}
																			type: "object"
																		}
																		syncOptions: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	type: "object"
																}
															}
															required: [
																"destination",
																"project",
															]
															type: "object"
														}
													}
													required: [
														"metadata",
														"spec",
													]
													type: "object"
												}
												values: {
													additionalProperties: type: "string"
													type: "object"
												}
											}
											required: ["configMapRef"]
											type: "object"
										}
										clusters: {
											properties: {
												selector: {
													properties: {
														matchExpressions: {
															items: {
																properties: {
																	key: type: "string"
																	operator: type: "string"
																	values: {
																		items: type: "string"
																		type: "array"
																	}
																}
																required: [
																	"key",
																	"operator",
																]
																type: "object"
															}
															type: "array"
														}
														matchLabels: {
															additionalProperties: type: "string"
															type: "object"
														}
													}
													type: "object"
												}
												template: {
													properties: {
														metadata: {
															properties: {
																annotations: {
																	additionalProperties: type: "string"
																	type: "object"
																}
																finalizers: {
																	items: type: "string"
																	type: "array"
																}
																labels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
																name: type: "string"
																namespace: type: "string"
															}
															type: "object"
														}
														spec: {
															properties: {
																destination: {
																	properties: {
																		name: type: "string"
																		namespace: type: "string"
																		server: type: "string"
																	}
																	type: "object"
																}
																ignoreDifferences: {
																	items: {
																		properties: {
																			group: type: "string"
																			jqPathExpressions: {
																				items: type: "string"
																				type: "array"
																			}
																			jsonPointers: {
																				items: type: "string"
																				type: "array"
																			}
																			kind: type: "string"
																			managedFieldsManagers: {
																				items: type: "string"
																				type: "array"
																			}
																			name: type: "string"
																			namespace: type: "string"
																		}
																		required: ["kind"]
																		type: "object"
																	}
																	type: "array"
																}
																info: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																project: type: "string"
																revisionHistoryLimit: {
																	format: "int64"
																	type:   "integer"
																}
																source: {
																	properties: {
																		chart: type: "string"
																		directory: {
																			properties: {
																				exclude: type: "string"
																				include: type: "string"
																				jsonnet: {
																					properties: {
																						extVars: {
																							items: {
																								properties: {
																									code: type: "boolean"
																									name: type: "string"
																									value: type: "string"
																								}
																								required: [
																									"name",
																									"value",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																						libs: {
																							items: type: "string"
																							type: "array"
																						}
																						tlas: {
																							items: {
																								properties: {
																									code: type: "boolean"
																									name: type: "string"
																									value: type: "string"
																								}
																								required: [
																									"name",
																									"value",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																					}
																					type: "object"
																				}
																				recurse: type: "boolean"
																			}
																			type: "object"
																		}
																		helm: {
																			properties: {
																				fileParameters: {
																					items: {
																						properties: {
																							name: type: "string"
																							path: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																				ignoreMissingValueFiles: type: "boolean"
																				parameters: {
																					items: {
																						properties: {
																							forceString: type: "boolean"
																							name: type: "string"
																							value: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																				passCredentials: type: "boolean"
																				releaseName: type: "string"
																				skipCrds: type: "boolean"
																				valueFiles: {
																					items: type: "string"
																					type: "array"
																				}
																				values: type: "string"
																				version: type: "string"
																			}
																			type: "object"
																		}
																		kustomize: {
																			properties: {
																				commonAnnotations: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				commonLabels: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				forceCommonAnnotations: type: "boolean"
																				forceCommonLabels: type: "boolean"
																				images: {
																					items: type: "string"
																					type: "array"
																				}
																				namePrefix: type: "string"
																				nameSuffix: type: "string"
																				version: type: "string"
																			}
																			type: "object"
																		}
																		path: type: "string"
																		plugin: {
																			properties: {
																				env: {
																					items: {
																						properties: {
																							name: type: "string"
																							value: type: "string"
																						}
																						required: [
																							"name",
																							"value",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				name: type: "string"
																				parameters: {
																					items: {
																						properties: {
																							array: {
																								items: type: "string"
																								type: "array"
																							}
																							map: {
																								additionalProperties: type: "string"
																								type: "object"
																							}
																							name: type: "string"
																							string: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																			}
																			type: "object"
																		}
																		ref: type: "string"
																		repoURL: type: "string"
																		targetRevision: type: "string"
																	}
																	required: ["repoURL"]
																	type: "object"
																}
																sources: {
																	items: {
																		properties: {
																			chart: type: "string"
																			directory: {
																				properties: {
																					exclude: type: "string"
																					include: type: "string"
																					jsonnet: {
																						properties: {
																							extVars: {
																								items: {
																									properties: {
																										code: type: "boolean"
																										name: type: "string"
																										value: type: "string"
																									}
																									required: [
																										"name",
																										"value",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																							libs: {
																								items: type: "string"
																								type: "array"
																							}
																							tlas: {
																								items: {
																									properties: {
																										code: type: "boolean"
																										name: type: "string"
																										value: type: "string"
																									}
																									required: [
																										"name",
																										"value",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																						}
																						type: "object"
																					}
																					recurse: type: "boolean"
																				}
																				type: "object"
																			}
																			helm: {
																				properties: {
																					fileParameters: {
																						items: {
																							properties: {
																								name: type: "string"
																								path: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																					ignoreMissingValueFiles: type: "boolean"
																					parameters: {
																						items: {
																							properties: {
																								forceString: type: "boolean"
																								name: type: "string"
																								value: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																					passCredentials: type: "boolean"
																					releaseName: type: "string"
																					skipCrds: type: "boolean"
																					valueFiles: {
																						items: type: "string"
																						type: "array"
																					}
																					values: type: "string"
																					version: type: "string"
																				}
																				type: "object"
																			}
																			kustomize: {
																				properties: {
																					commonAnnotations: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					commonLabels: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					forceCommonAnnotations: type: "boolean"
																					forceCommonLabels: type: "boolean"
																					images: {
																						items: type: "string"
																						type: "array"
																					}
																					namePrefix: type: "string"
																					nameSuffix: type: "string"
																					version: type: "string"
																				}
																				type: "object"
																			}
																			path: type: "string"
																			plugin: {
																				properties: {
																					env: {
																						items: {
																							properties: {
																								name: type: "string"
																								value: type: "string"
																							}
																							required: [
																								"name",
																								"value",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					name: type: "string"
																					parameters: {
																						items: {
																							properties: {
																								array: {
																									items: type: "string"
																									type: "array"
																								}
																								map: {
																									additionalProperties: type: "string"
																									type: "object"
																								}
																								name: type: "string"
																								string: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																				}
																				type: "object"
																			}
																			ref: type: "string"
																			repoURL: type: "string"
																			targetRevision: type: "string"
																		}
																		required: ["repoURL"]
																		type: "object"
																	}
																	type: "array"
																}
																syncPolicy: {
																	properties: {
																		automated: {
																			properties: {
																				allowEmpty: type: "boolean"
																				prune: type: "boolean"
																				selfHeal: type: "boolean"
																			}
																			type: "object"
																		}
																		managedNamespaceMetadata: {
																			properties: {
																				annotations: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				labels: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																			}
																			type: "object"
																		}
																		retry: {
																			properties: {
																				backoff: {
																					properties: {
																						duration: type: "string"
																						factor: {
																							format: "int64"
																							type:   "integer"
																						}
																						maxDuration: type: "string"
																					}
																					type: "object"
																				}
																				limit: {
																					format: "int64"
																					type:   "integer"
																				}
																			}
																			type: "object"
																		}
																		syncOptions: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	type: "object"
																}
															}
															required: [
																"destination",
																"project",
															]
															type: "object"
														}
													}
													required: [
														"metadata",
														"spec",
													]
													type: "object"
												}
												values: {
													additionalProperties: type: "string"
													type: "object"
												}
											}
											type: "object"
										}
										git: {
											properties: {
												directories: {
													items: {
														properties: {
															exclude: type: "boolean"
															path: type: "string"
														}
														required: ["path"]
														type: "object"
													}
													type: "array"
												}
												files: {
													items: {
														properties: path: type: "string"
														required: ["path"]
														type: "object"
													}
													type: "array"
												}
												pathParamPrefix: type: "string"
												repoURL: type: "string"
												requeueAfterSeconds: {
													format: "int64"
													type:   "integer"
												}
												revision: type: "string"
												template: {
													properties: {
														metadata: {
															properties: {
																annotations: {
																	additionalProperties: type: "string"
																	type: "object"
																}
																finalizers: {
																	items: type: "string"
																	type: "array"
																}
																labels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
																name: type: "string"
																namespace: type: "string"
															}
															type: "object"
														}
														spec: {
															properties: {
																destination: {
																	properties: {
																		name: type: "string"
																		namespace: type: "string"
																		server: type: "string"
																	}
																	type: "object"
																}
																ignoreDifferences: {
																	items: {
																		properties: {
																			group: type: "string"
																			jqPathExpressions: {
																				items: type: "string"
																				type: "array"
																			}
																			jsonPointers: {
																				items: type: "string"
																				type: "array"
																			}
																			kind: type: "string"
																			managedFieldsManagers: {
																				items: type: "string"
																				type: "array"
																			}
																			name: type: "string"
																			namespace: type: "string"
																		}
																		required: ["kind"]
																		type: "object"
																	}
																	type: "array"
																}
																info: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																project: type: "string"
																revisionHistoryLimit: {
																	format: "int64"
																	type:   "integer"
																}
																source: {
																	properties: {
																		chart: type: "string"
																		directory: {
																			properties: {
																				exclude: type: "string"
																				include: type: "string"
																				jsonnet: {
																					properties: {
																						extVars: {
																							items: {
																								properties: {
																									code: type: "boolean"
																									name: type: "string"
																									value: type: "string"
																								}
																								required: [
																									"name",
																									"value",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																						libs: {
																							items: type: "string"
																							type: "array"
																						}
																						tlas: {
																							items: {
																								properties: {
																									code: type: "boolean"
																									name: type: "string"
																									value: type: "string"
																								}
																								required: [
																									"name",
																									"value",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																					}
																					type: "object"
																				}
																				recurse: type: "boolean"
																			}
																			type: "object"
																		}
																		helm: {
																			properties: {
																				fileParameters: {
																					items: {
																						properties: {
																							name: type: "string"
																							path: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																				ignoreMissingValueFiles: type: "boolean"
																				parameters: {
																					items: {
																						properties: {
																							forceString: type: "boolean"
																							name: type: "string"
																							value: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																				passCredentials: type: "boolean"
																				releaseName: type: "string"
																				skipCrds: type: "boolean"
																				valueFiles: {
																					items: type: "string"
																					type: "array"
																				}
																				values: type: "string"
																				version: type: "string"
																			}
																			type: "object"
																		}
																		kustomize: {
																			properties: {
																				commonAnnotations: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				commonLabels: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				forceCommonAnnotations: type: "boolean"
																				forceCommonLabels: type: "boolean"
																				images: {
																					items: type: "string"
																					type: "array"
																				}
																				namePrefix: type: "string"
																				nameSuffix: type: "string"
																				version: type: "string"
																			}
																			type: "object"
																		}
																		path: type: "string"
																		plugin: {
																			properties: {
																				env: {
																					items: {
																						properties: {
																							name: type: "string"
																							value: type: "string"
																						}
																						required: [
																							"name",
																							"value",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				name: type: "string"
																				parameters: {
																					items: {
																						properties: {
																							array: {
																								items: type: "string"
																								type: "array"
																							}
																							map: {
																								additionalProperties: type: "string"
																								type: "object"
																							}
																							name: type: "string"
																							string: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																			}
																			type: "object"
																		}
																		ref: type: "string"
																		repoURL: type: "string"
																		targetRevision: type: "string"
																	}
																	required: ["repoURL"]
																	type: "object"
																}
																sources: {
																	items: {
																		properties: {
																			chart: type: "string"
																			directory: {
																				properties: {
																					exclude: type: "string"
																					include: type: "string"
																					jsonnet: {
																						properties: {
																							extVars: {
																								items: {
																									properties: {
																										code: type: "boolean"
																										name: type: "string"
																										value: type: "string"
																									}
																									required: [
																										"name",
																										"value",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																							libs: {
																								items: type: "string"
																								type: "array"
																							}
																							tlas: {
																								items: {
																									properties: {
																										code: type: "boolean"
																										name: type: "string"
																										value: type: "string"
																									}
																									required: [
																										"name",
																										"value",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																						}
																						type: "object"
																					}
																					recurse: type: "boolean"
																				}
																				type: "object"
																			}
																			helm: {
																				properties: {
																					fileParameters: {
																						items: {
																							properties: {
																								name: type: "string"
																								path: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																					ignoreMissingValueFiles: type: "boolean"
																					parameters: {
																						items: {
																							properties: {
																								forceString: type: "boolean"
																								name: type: "string"
																								value: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																					passCredentials: type: "boolean"
																					releaseName: type: "string"
																					skipCrds: type: "boolean"
																					valueFiles: {
																						items: type: "string"
																						type: "array"
																					}
																					values: type: "string"
																					version: type: "string"
																				}
																				type: "object"
																			}
																			kustomize: {
																				properties: {
																					commonAnnotations: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					commonLabels: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					forceCommonAnnotations: type: "boolean"
																					forceCommonLabels: type: "boolean"
																					images: {
																						items: type: "string"
																						type: "array"
																					}
																					namePrefix: type: "string"
																					nameSuffix: type: "string"
																					version: type: "string"
																				}
																				type: "object"
																			}
																			path: type: "string"
																			plugin: {
																				properties: {
																					env: {
																						items: {
																							properties: {
																								name: type: "string"
																								value: type: "string"
																							}
																							required: [
																								"name",
																								"value",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					name: type: "string"
																					parameters: {
																						items: {
																							properties: {
																								array: {
																									items: type: "string"
																									type: "array"
																								}
																								map: {
																									additionalProperties: type: "string"
																									type: "object"
																								}
																								name: type: "string"
																								string: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																				}
																				type: "object"
																			}
																			ref: type: "string"
																			repoURL: type: "string"
																			targetRevision: type: "string"
																		}
																		required: ["repoURL"]
																		type: "object"
																	}
																	type: "array"
																}
																syncPolicy: {
																	properties: {
																		automated: {
																			properties: {
																				allowEmpty: type: "boolean"
																				prune: type: "boolean"
																				selfHeal: type: "boolean"
																			}
																			type: "object"
																		}
																		managedNamespaceMetadata: {
																			properties: {
																				annotations: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				labels: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																			}
																			type: "object"
																		}
																		retry: {
																			properties: {
																				backoff: {
																					properties: {
																						duration: type: "string"
																						factor: {
																							format: "int64"
																							type:   "integer"
																						}
																						maxDuration: type: "string"
																					}
																					type: "object"
																				}
																				limit: {
																					format: "int64"
																					type:   "integer"
																				}
																			}
																			type: "object"
																		}
																		syncOptions: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	type: "object"
																}
															}
															required: [
																"destination",
																"project",
															]
															type: "object"
														}
													}
													required: [
														"metadata",
														"spec",
													]
													type: "object"
												}
											}
											required: [
												"repoURL",
												"revision",
											]
											type: "object"
										}
										list: {
											properties: {
												elements: {
													items: "x-kubernetes-preserve-unknown-fields": true
													type: "array"
												}
												template: {
													properties: {
														metadata: {
															properties: {
																annotations: {
																	additionalProperties: type: "string"
																	type: "object"
																}
																finalizers: {
																	items: type: "string"
																	type: "array"
																}
																labels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
																name: type: "string"
																namespace: type: "string"
															}
															type: "object"
														}
														spec: {
															properties: {
																destination: {
																	properties: {
																		name: type: "string"
																		namespace: type: "string"
																		server: type: "string"
																	}
																	type: "object"
																}
																ignoreDifferences: {
																	items: {
																		properties: {
																			group: type: "string"
																			jqPathExpressions: {
																				items: type: "string"
																				type: "array"
																			}
																			jsonPointers: {
																				items: type: "string"
																				type: "array"
																			}
																			kind: type: "string"
																			managedFieldsManagers: {
																				items: type: "string"
																				type: "array"
																			}
																			name: type: "string"
																			namespace: type: "string"
																		}
																		required: ["kind"]
																		type: "object"
																	}
																	type: "array"
																}
																info: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																project: type: "string"
																revisionHistoryLimit: {
																	format: "int64"
																	type:   "integer"
																}
																source: {
																	properties: {
																		chart: type: "string"
																		directory: {
																			properties: {
																				exclude: type: "string"
																				include: type: "string"
																				jsonnet: {
																					properties: {
																						extVars: {
																							items: {
																								properties: {
																									code: type: "boolean"
																									name: type: "string"
																									value: type: "string"
																								}
																								required: [
																									"name",
																									"value",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																						libs: {
																							items: type: "string"
																							type: "array"
																						}
																						tlas: {
																							items: {
																								properties: {
																									code: type: "boolean"
																									name: type: "string"
																									value: type: "string"
																								}
																								required: [
																									"name",
																									"value",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																					}
																					type: "object"
																				}
																				recurse: type: "boolean"
																			}
																			type: "object"
																		}
																		helm: {
																			properties: {
																				fileParameters: {
																					items: {
																						properties: {
																							name: type: "string"
																							path: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																				ignoreMissingValueFiles: type: "boolean"
																				parameters: {
																					items: {
																						properties: {
																							forceString: type: "boolean"
																							name: type: "string"
																							value: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																				passCredentials: type: "boolean"
																				releaseName: type: "string"
																				skipCrds: type: "boolean"
																				valueFiles: {
																					items: type: "string"
																					type: "array"
																				}
																				values: type: "string"
																				version: type: "string"
																			}
																			type: "object"
																		}
																		kustomize: {
																			properties: {
																				commonAnnotations: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				commonLabels: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				forceCommonAnnotations: type: "boolean"
																				forceCommonLabels: type: "boolean"
																				images: {
																					items: type: "string"
																					type: "array"
																				}
																				namePrefix: type: "string"
																				nameSuffix: type: "string"
																				version: type: "string"
																			}
																			type: "object"
																		}
																		path: type: "string"
																		plugin: {
																			properties: {
																				env: {
																					items: {
																						properties: {
																							name: type: "string"
																							value: type: "string"
																						}
																						required: [
																							"name",
																							"value",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				name: type: "string"
																				parameters: {
																					items: {
																						properties: {
																							array: {
																								items: type: "string"
																								type: "array"
																							}
																							map: {
																								additionalProperties: type: "string"
																								type: "object"
																							}
																							name: type: "string"
																							string: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																			}
																			type: "object"
																		}
																		ref: type: "string"
																		repoURL: type: "string"
																		targetRevision: type: "string"
																	}
																	required: ["repoURL"]
																	type: "object"
																}
																sources: {
																	items: {
																		properties: {
																			chart: type: "string"
																			directory: {
																				properties: {
																					exclude: type: "string"
																					include: type: "string"
																					jsonnet: {
																						properties: {
																							extVars: {
																								items: {
																									properties: {
																										code: type: "boolean"
																										name: type: "string"
																										value: type: "string"
																									}
																									required: [
																										"name",
																										"value",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																							libs: {
																								items: type: "string"
																								type: "array"
																							}
																							tlas: {
																								items: {
																									properties: {
																										code: type: "boolean"
																										name: type: "string"
																										value: type: "string"
																									}
																									required: [
																										"name",
																										"value",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																						}
																						type: "object"
																					}
																					recurse: type: "boolean"
																				}
																				type: "object"
																			}
																			helm: {
																				properties: {
																					fileParameters: {
																						items: {
																							properties: {
																								name: type: "string"
																								path: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																					ignoreMissingValueFiles: type: "boolean"
																					parameters: {
																						items: {
																							properties: {
																								forceString: type: "boolean"
																								name: type: "string"
																								value: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																					passCredentials: type: "boolean"
																					releaseName: type: "string"
																					skipCrds: type: "boolean"
																					valueFiles: {
																						items: type: "string"
																						type: "array"
																					}
																					values: type: "string"
																					version: type: "string"
																				}
																				type: "object"
																			}
																			kustomize: {
																				properties: {
																					commonAnnotations: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					commonLabels: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					forceCommonAnnotations: type: "boolean"
																					forceCommonLabels: type: "boolean"
																					images: {
																						items: type: "string"
																						type: "array"
																					}
																					namePrefix: type: "string"
																					nameSuffix: type: "string"
																					version: type: "string"
																				}
																				type: "object"
																			}
																			path: type: "string"
																			plugin: {
																				properties: {
																					env: {
																						items: {
																							properties: {
																								name: type: "string"
																								value: type: "string"
																							}
																							required: [
																								"name",
																								"value",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					name: type: "string"
																					parameters: {
																						items: {
																							properties: {
																								array: {
																									items: type: "string"
																									type: "array"
																								}
																								map: {
																									additionalProperties: type: "string"
																									type: "object"
																								}
																								name: type: "string"
																								string: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																				}
																				type: "object"
																			}
																			ref: type: "string"
																			repoURL: type: "string"
																			targetRevision: type: "string"
																		}
																		required: ["repoURL"]
																		type: "object"
																	}
																	type: "array"
																}
																syncPolicy: {
																	properties: {
																		automated: {
																			properties: {
																				allowEmpty: type: "boolean"
																				prune: type: "boolean"
																				selfHeal: type: "boolean"
																			}
																			type: "object"
																		}
																		managedNamespaceMetadata: {
																			properties: {
																				annotations: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				labels: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																			}
																			type: "object"
																		}
																		retry: {
																			properties: {
																				backoff: {
																					properties: {
																						duration: type: "string"
																						factor: {
																							format: "int64"
																							type:   "integer"
																						}
																						maxDuration: type: "string"
																					}
																					type: "object"
																				}
																				limit: {
																					format: "int64"
																					type:   "integer"
																				}
																			}
																			type: "object"
																		}
																		syncOptions: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	type: "object"
																}
															}
															required: [
																"destination",
																"project",
															]
															type: "object"
														}
													}
													required: [
														"metadata",
														"spec",
													]
													type: "object"
												}
											}
											required: ["elements"]
											type: "object"
										}
										matrix: {
											properties: {
												generators: {
													items: {
														properties: {
															clusterDecisionResource: {
																properties: {
																	configMapRef: type: "string"
																	labelSelector: {
																		properties: {
																			matchExpressions: {
																				items: {
																					properties: {
																						key: type: "string"
																						operator: type: "string"
																						values: {
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchLabels: {
																				additionalProperties: type: "string"
																				type: "object"
																			}
																		}
																		type: "object"
																	}
																	name: type: "string"
																	requeueAfterSeconds: {
																		format: "int64"
																		type:   "integer"
																	}
																	template: {
																		properties: {
																			metadata: {
																				properties: {
																					annotations: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					finalizers: {
																						items: type: "string"
																						type: "array"
																					}
																					labels: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					name: type: "string"
																					namespace: type: "string"
																				}
																				type: "object"
																			}
																			spec: {
																				properties: {
																					destination: {
																						properties: {
																							name: type: "string"
																							namespace: type: "string"
																							server: type: "string"
																						}
																						type: "object"
																					}
																					ignoreDifferences: {
																						items: {
																							properties: {
																								group: type: "string"
																								jqPathExpressions: {
																									items: type: "string"
																									type: "array"
																								}
																								jsonPointers: {
																									items: type: "string"
																									type: "array"
																								}
																								kind: type: "string"
																								managedFieldsManagers: {
																									items: type: "string"
																									type: "array"
																								}
																								name: type: "string"
																								namespace: type: "string"
																							}
																							required: ["kind"]
																							type: "object"
																						}
																						type: "array"
																					}
																					info: {
																						items: {
																							properties: {
																								name: type: "string"
																								value: type: "string"
																							}
																							required: [
																								"name",
																								"value",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					project: type: "string"
																					revisionHistoryLimit: {
																						format: "int64"
																						type:   "integer"
																					}
																					source: {
																						properties: {
																							chart: type: "string"
																							directory: {
																								properties: {
																									exclude: type: "string"
																									include: type: "string"
																									jsonnet: {
																										properties: {
																											extVars: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																											libs: {
																												items: type: "string"
																												type: "array"
																											}
																											tlas: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																										}
																										type: "object"
																									}
																									recurse: type: "boolean"
																								}
																								type: "object"
																							}
																							helm: {
																								properties: {
																									fileParameters: {
																										items: {
																											properties: {
																												name: type: "string"
																												path: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									ignoreMissingValueFiles: type: "boolean"
																									parameters: {
																										items: {
																											properties: {
																												forceString: type: "boolean"
																												name: type: "string"
																												value: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									passCredentials: type: "boolean"
																									releaseName: type: "string"
																									skipCrds: type: "boolean"
																									valueFiles: {
																										items: type: "string"
																										type: "array"
																									}
																									values: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							kustomize: {
																								properties: {
																									commonAnnotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									commonLabels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									forceCommonAnnotations: type: "boolean"
																									forceCommonLabels: type: "boolean"
																									images: {
																										items: type: "string"
																										type: "array"
																									}
																									namePrefix: type: "string"
																									nameSuffix: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							path: type: "string"
																							plugin: {
																								properties: {
																									env: {
																										items: {
																											properties: {
																												name: type: "string"
																												value: type: "string"
																											}
																											required: [
																												"name",
																												"value",
																											]
																											type: "object"
																										}
																										type: "array"
																									}
																									name: type: "string"
																									parameters: {
																										items: {
																											properties: {
																												array: {
																													items: type: "string"
																													type: "array"
																												}
																												map: {
																													additionalProperties: type: "string"
																													type: "object"
																												}
																												name: type: "string"
																												string: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																								}
																								type: "object"
																							}
																							ref: type: "string"
																							repoURL: type: "string"
																							targetRevision: type: "string"
																						}
																						required: ["repoURL"]
																						type: "object"
																					}
																					sources: {
																						items: {
																							properties: {
																								chart: type: "string"
																								directory: {
																									properties: {
																										exclude: type: "string"
																										include: type: "string"
																										jsonnet: {
																											properties: {
																												extVars: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																												libs: {
																													items: type: "string"
																													type: "array"
																												}
																												tlas: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																											}
																											type: "object"
																										}
																										recurse: type: "boolean"
																									}
																									type: "object"
																								}
																								helm: {
																									properties: {
																										fileParameters: {
																											items: {
																												properties: {
																													name: type: "string"
																													path: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										ignoreMissingValueFiles: type: "boolean"
																										parameters: {
																											items: {
																												properties: {
																													forceString: type: "boolean"
																													name: type: "string"
																													value: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										passCredentials: type: "boolean"
																										releaseName: type: "string"
																										skipCrds: type: "boolean"
																										valueFiles: {
																											items: type: "string"
																											type: "array"
																										}
																										values: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								kustomize: {
																									properties: {
																										commonAnnotations: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										commonLabels: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										forceCommonAnnotations: type: "boolean"
																										forceCommonLabels: type: "boolean"
																										images: {
																											items: type: "string"
																											type: "array"
																										}
																										namePrefix: type: "string"
																										nameSuffix: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								path: type: "string"
																								plugin: {
																									properties: {
																										env: {
																											items: {
																												properties: {
																													name: type: "string"
																													value: type: "string"
																												}
																												required: [
																													"name",
																													"value",
																												]
																												type: "object"
																											}
																											type: "array"
																										}
																										name: type: "string"
																										parameters: {
																											items: {
																												properties: {
																													array: {
																														items: type: "string"
																														type: "array"
																													}
																													map: {
																														additionalProperties: type: "string"
																														type: "object"
																													}
																													name: type: "string"
																													string: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																									}
																									type: "object"
																								}
																								ref: type: "string"
																								repoURL: type: "string"
																								targetRevision: type: "string"
																							}
																							required: ["repoURL"]
																							type: "object"
																						}
																						type: "array"
																					}
																					syncPolicy: {
																						properties: {
																							automated: {
																								properties: {
																									allowEmpty: type: "boolean"
																									prune: type: "boolean"
																									selfHeal: type: "boolean"
																								}
																								type: "object"
																							}
																							managedNamespaceMetadata: {
																								properties: {
																									annotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									labels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																								}
																								type: "object"
																							}
																							retry: {
																								properties: {
																									backoff: {
																										properties: {
																											duration: type: "string"
																											factor: {
																												format: "int64"
																												type:   "integer"
																											}
																											maxDuration: type: "string"
																										}
																										type: "object"
																									}
																									limit: {
																										format: "int64"
																										type:   "integer"
																									}
																								}
																								type: "object"
																							}
																							syncOptions: {
																								items: type: "string"
																								type: "array"
																							}
																						}
																						type: "object"
																					}
																				}
																				required: [
																					"destination",
																					"project",
																				]
																				type: "object"
																			}
																		}
																		required: [
																			"metadata",
																			"spec",
																		]
																		type: "object"
																	}
																	values: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																}
																required: ["configMapRef"]
																type: "object"
															}
															clusters: {
																properties: {
																	selector: {
																		properties: {
																			matchExpressions: {
																				items: {
																					properties: {
																						key: type: "string"
																						operator: type: "string"
																						values: {
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchLabels: {
																				additionalProperties: type: "string"
																				type: "object"
																			}
																		}
																		type: "object"
																	}
																	template: {
																		properties: {
																			metadata: {
																				properties: {
																					annotations: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					finalizers: {
																						items: type: "string"
																						type: "array"
																					}
																					labels: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					name: type: "string"
																					namespace: type: "string"
																				}
																				type: "object"
																			}
																			spec: {
																				properties: {
																					destination: {
																						properties: {
																							name: type: "string"
																							namespace: type: "string"
																							server: type: "string"
																						}
																						type: "object"
																					}
																					ignoreDifferences: {
																						items: {
																							properties: {
																								group: type: "string"
																								jqPathExpressions: {
																									items: type: "string"
																									type: "array"
																								}
																								jsonPointers: {
																									items: type: "string"
																									type: "array"
																								}
																								kind: type: "string"
																								managedFieldsManagers: {
																									items: type: "string"
																									type: "array"
																								}
																								name: type: "string"
																								namespace: type: "string"
																							}
																							required: ["kind"]
																							type: "object"
																						}
																						type: "array"
																					}
																					info: {
																						items: {
																							properties: {
																								name: type: "string"
																								value: type: "string"
																							}
																							required: [
																								"name",
																								"value",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					project: type: "string"
																					revisionHistoryLimit: {
																						format: "int64"
																						type:   "integer"
																					}
																					source: {
																						properties: {
																							chart: type: "string"
																							directory: {
																								properties: {
																									exclude: type: "string"
																									include: type: "string"
																									jsonnet: {
																										properties: {
																											extVars: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																											libs: {
																												items: type: "string"
																												type: "array"
																											}
																											tlas: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																										}
																										type: "object"
																									}
																									recurse: type: "boolean"
																								}
																								type: "object"
																							}
																							helm: {
																								properties: {
																									fileParameters: {
																										items: {
																											properties: {
																												name: type: "string"
																												path: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									ignoreMissingValueFiles: type: "boolean"
																									parameters: {
																										items: {
																											properties: {
																												forceString: type: "boolean"
																												name: type: "string"
																												value: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									passCredentials: type: "boolean"
																									releaseName: type: "string"
																									skipCrds: type: "boolean"
																									valueFiles: {
																										items: type: "string"
																										type: "array"
																									}
																									values: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							kustomize: {
																								properties: {
																									commonAnnotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									commonLabels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									forceCommonAnnotations: type: "boolean"
																									forceCommonLabels: type: "boolean"
																									images: {
																										items: type: "string"
																										type: "array"
																									}
																									namePrefix: type: "string"
																									nameSuffix: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							path: type: "string"
																							plugin: {
																								properties: {
																									env: {
																										items: {
																											properties: {
																												name: type: "string"
																												value: type: "string"
																											}
																											required: [
																												"name",
																												"value",
																											]
																											type: "object"
																										}
																										type: "array"
																									}
																									name: type: "string"
																									parameters: {
																										items: {
																											properties: {
																												array: {
																													items: type: "string"
																													type: "array"
																												}
																												map: {
																													additionalProperties: type: "string"
																													type: "object"
																												}
																												name: type: "string"
																												string: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																								}
																								type: "object"
																							}
																							ref: type: "string"
																							repoURL: type: "string"
																							targetRevision: type: "string"
																						}
																						required: ["repoURL"]
																						type: "object"
																					}
																					sources: {
																						items: {
																							properties: {
																								chart: type: "string"
																								directory: {
																									properties: {
																										exclude: type: "string"
																										include: type: "string"
																										jsonnet: {
																											properties: {
																												extVars: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																												libs: {
																													items: type: "string"
																													type: "array"
																												}
																												tlas: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																											}
																											type: "object"
																										}
																										recurse: type: "boolean"
																									}
																									type: "object"
																								}
																								helm: {
																									properties: {
																										fileParameters: {
																											items: {
																												properties: {
																													name: type: "string"
																													path: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										ignoreMissingValueFiles: type: "boolean"
																										parameters: {
																											items: {
																												properties: {
																													forceString: type: "boolean"
																													name: type: "string"
																													value: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										passCredentials: type: "boolean"
																										releaseName: type: "string"
																										skipCrds: type: "boolean"
																										valueFiles: {
																											items: type: "string"
																											type: "array"
																										}
																										values: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								kustomize: {
																									properties: {
																										commonAnnotations: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										commonLabels: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										forceCommonAnnotations: type: "boolean"
																										forceCommonLabels: type: "boolean"
																										images: {
																											items: type: "string"
																											type: "array"
																										}
																										namePrefix: type: "string"
																										nameSuffix: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								path: type: "string"
																								plugin: {
																									properties: {
																										env: {
																											items: {
																												properties: {
																													name: type: "string"
																													value: type: "string"
																												}
																												required: [
																													"name",
																													"value",
																												]
																												type: "object"
																											}
																											type: "array"
																										}
																										name: type: "string"
																										parameters: {
																											items: {
																												properties: {
																													array: {
																														items: type: "string"
																														type: "array"
																													}
																													map: {
																														additionalProperties: type: "string"
																														type: "object"
																													}
																													name: type: "string"
																													string: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																									}
																									type: "object"
																								}
																								ref: type: "string"
																								repoURL: type: "string"
																								targetRevision: type: "string"
																							}
																							required: ["repoURL"]
																							type: "object"
																						}
																						type: "array"
																					}
																					syncPolicy: {
																						properties: {
																							automated: {
																								properties: {
																									allowEmpty: type: "boolean"
																									prune: type: "boolean"
																									selfHeal: type: "boolean"
																								}
																								type: "object"
																							}
																							managedNamespaceMetadata: {
																								properties: {
																									annotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									labels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																								}
																								type: "object"
																							}
																							retry: {
																								properties: {
																									backoff: {
																										properties: {
																											duration: type: "string"
																											factor: {
																												format: "int64"
																												type:   "integer"
																											}
																											maxDuration: type: "string"
																										}
																										type: "object"
																									}
																									limit: {
																										format: "int64"
																										type:   "integer"
																									}
																								}
																								type: "object"
																							}
																							syncOptions: {
																								items: type: "string"
																								type: "array"
																							}
																						}
																						type: "object"
																					}
																				}
																				required: [
																					"destination",
																					"project",
																				]
																				type: "object"
																			}
																		}
																		required: [
																			"metadata",
																			"spec",
																		]
																		type: "object"
																	}
																	values: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																}
																type: "object"
															}
															git: {
																properties: {
																	directories: {
																		items: {
																			properties: {
																				exclude: type: "boolean"
																				path: type: "string"
																			}
																			required: ["path"]
																			type: "object"
																		}
																		type: "array"
																	}
																	files: {
																		items: {
																			properties: path: type: "string"
																			required: ["path"]
																			type: "object"
																		}
																		type: "array"
																	}
																	pathParamPrefix: type: "string"
																	repoURL: type: "string"
																	requeueAfterSeconds: {
																		format: "int64"
																		type:   "integer"
																	}
																	revision: type: "string"
																	template: {
																		properties: {
																			metadata: {
																				properties: {
																					annotations: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					finalizers: {
																						items: type: "string"
																						type: "array"
																					}
																					labels: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					name: type: "string"
																					namespace: type: "string"
																				}
																				type: "object"
																			}
																			spec: {
																				properties: {
																					destination: {
																						properties: {
																							name: type: "string"
																							namespace: type: "string"
																							server: type: "string"
																						}
																						type: "object"
																					}
																					ignoreDifferences: {
																						items: {
																							properties: {
																								group: type: "string"
																								jqPathExpressions: {
																									items: type: "string"
																									type: "array"
																								}
																								jsonPointers: {
																									items: type: "string"
																									type: "array"
																								}
																								kind: type: "string"
																								managedFieldsManagers: {
																									items: type: "string"
																									type: "array"
																								}
																								name: type: "string"
																								namespace: type: "string"
																							}
																							required: ["kind"]
																							type: "object"
																						}
																						type: "array"
																					}
																					info: {
																						items: {
																							properties: {
																								name: type: "string"
																								value: type: "string"
																							}
																							required: [
																								"name",
																								"value",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					project: type: "string"
																					revisionHistoryLimit: {
																						format: "int64"
																						type:   "integer"
																					}
																					source: {
																						properties: {
																							chart: type: "string"
																							directory: {
																								properties: {
																									exclude: type: "string"
																									include: type: "string"
																									jsonnet: {
																										properties: {
																											extVars: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																											libs: {
																												items: type: "string"
																												type: "array"
																											}
																											tlas: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																										}
																										type: "object"
																									}
																									recurse: type: "boolean"
																								}
																								type: "object"
																							}
																							helm: {
																								properties: {
																									fileParameters: {
																										items: {
																											properties: {
																												name: type: "string"
																												path: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									ignoreMissingValueFiles: type: "boolean"
																									parameters: {
																										items: {
																											properties: {
																												forceString: type: "boolean"
																												name: type: "string"
																												value: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									passCredentials: type: "boolean"
																									releaseName: type: "string"
																									skipCrds: type: "boolean"
																									valueFiles: {
																										items: type: "string"
																										type: "array"
																									}
																									values: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							kustomize: {
																								properties: {
																									commonAnnotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									commonLabels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									forceCommonAnnotations: type: "boolean"
																									forceCommonLabels: type: "boolean"
																									images: {
																										items: type: "string"
																										type: "array"
																									}
																									namePrefix: type: "string"
																									nameSuffix: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							path: type: "string"
																							plugin: {
																								properties: {
																									env: {
																										items: {
																											properties: {
																												name: type: "string"
																												value: type: "string"
																											}
																											required: [
																												"name",
																												"value",
																											]
																											type: "object"
																										}
																										type: "array"
																									}
																									name: type: "string"
																									parameters: {
																										items: {
																											properties: {
																												array: {
																													items: type: "string"
																													type: "array"
																												}
																												map: {
																													additionalProperties: type: "string"
																													type: "object"
																												}
																												name: type: "string"
																												string: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																								}
																								type: "object"
																							}
																							ref: type: "string"
																							repoURL: type: "string"
																							targetRevision: type: "string"
																						}
																						required: ["repoURL"]
																						type: "object"
																					}
																					sources: {
																						items: {
																							properties: {
																								chart: type: "string"
																								directory: {
																									properties: {
																										exclude: type: "string"
																										include: type: "string"
																										jsonnet: {
																											properties: {
																												extVars: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																												libs: {
																													items: type: "string"
																													type: "array"
																												}
																												tlas: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																											}
																											type: "object"
																										}
																										recurse: type: "boolean"
																									}
																									type: "object"
																								}
																								helm: {
																									properties: {
																										fileParameters: {
																											items: {
																												properties: {
																													name: type: "string"
																													path: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										ignoreMissingValueFiles: type: "boolean"
																										parameters: {
																											items: {
																												properties: {
																													forceString: type: "boolean"
																													name: type: "string"
																													value: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										passCredentials: type: "boolean"
																										releaseName: type: "string"
																										skipCrds: type: "boolean"
																										valueFiles: {
																											items: type: "string"
																											type: "array"
																										}
																										values: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								kustomize: {
																									properties: {
																										commonAnnotations: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										commonLabels: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										forceCommonAnnotations: type: "boolean"
																										forceCommonLabels: type: "boolean"
																										images: {
																											items: type: "string"
																											type: "array"
																										}
																										namePrefix: type: "string"
																										nameSuffix: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								path: type: "string"
																								plugin: {
																									properties: {
																										env: {
																											items: {
																												properties: {
																													name: type: "string"
																													value: type: "string"
																												}
																												required: [
																													"name",
																													"value",
																												]
																												type: "object"
																											}
																											type: "array"
																										}
																										name: type: "string"
																										parameters: {
																											items: {
																												properties: {
																													array: {
																														items: type: "string"
																														type: "array"
																													}
																													map: {
																														additionalProperties: type: "string"
																														type: "object"
																													}
																													name: type: "string"
																													string: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																									}
																									type: "object"
																								}
																								ref: type: "string"
																								repoURL: type: "string"
																								targetRevision: type: "string"
																							}
																							required: ["repoURL"]
																							type: "object"
																						}
																						type: "array"
																					}
																					syncPolicy: {
																						properties: {
																							automated: {
																								properties: {
																									allowEmpty: type: "boolean"
																									prune: type: "boolean"
																									selfHeal: type: "boolean"
																								}
																								type: "object"
																							}
																							managedNamespaceMetadata: {
																								properties: {
																									annotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									labels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																								}
																								type: "object"
																							}
																							retry: {
																								properties: {
																									backoff: {
																										properties: {
																											duration: type: "string"
																											factor: {
																												format: "int64"
																												type:   "integer"
																											}
																											maxDuration: type: "string"
																										}
																										type: "object"
																									}
																									limit: {
																										format: "int64"
																										type:   "integer"
																									}
																								}
																								type: "object"
																							}
																							syncOptions: {
																								items: type: "string"
																								type: "array"
																							}
																						}
																						type: "object"
																					}
																				}
																				required: [
																					"destination",
																					"project",
																				]
																				type: "object"
																			}
																		}
																		required: [
																			"metadata",
																			"spec",
																		]
																		type: "object"
																	}
																}
																required: [
																	"repoURL",
																	"revision",
																]
																type: "object"
															}
															list: {
																properties: {
																	elements: {
																		items: "x-kubernetes-preserve-unknown-fields": true
																		type: "array"
																	}
																	template: {
																		properties: {
																			metadata: {
																				properties: {
																					annotations: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					finalizers: {
																						items: type: "string"
																						type: "array"
																					}
																					labels: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					name: type: "string"
																					namespace: type: "string"
																				}
																				type: "object"
																			}
																			spec: {
																				properties: {
																					destination: {
																						properties: {
																							name: type: "string"
																							namespace: type: "string"
																							server: type: "string"
																						}
																						type: "object"
																					}
																					ignoreDifferences: {
																						items: {
																							properties: {
																								group: type: "string"
																								jqPathExpressions: {
																									items: type: "string"
																									type: "array"
																								}
																								jsonPointers: {
																									items: type: "string"
																									type: "array"
																								}
																								kind: type: "string"
																								managedFieldsManagers: {
																									items: type: "string"
																									type: "array"
																								}
																								name: type: "string"
																								namespace: type: "string"
																							}
																							required: ["kind"]
																							type: "object"
																						}
																						type: "array"
																					}
																					info: {
																						items: {
																							properties: {
																								name: type: "string"
																								value: type: "string"
																							}
																							required: [
																								"name",
																								"value",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					project: type: "string"
																					revisionHistoryLimit: {
																						format: "int64"
																						type:   "integer"
																					}
																					source: {
																						properties: {
																							chart: type: "string"
																							directory: {
																								properties: {
																									exclude: type: "string"
																									include: type: "string"
																									jsonnet: {
																										properties: {
																											extVars: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																											libs: {
																												items: type: "string"
																												type: "array"
																											}
																											tlas: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																										}
																										type: "object"
																									}
																									recurse: type: "boolean"
																								}
																								type: "object"
																							}
																							helm: {
																								properties: {
																									fileParameters: {
																										items: {
																											properties: {
																												name: type: "string"
																												path: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									ignoreMissingValueFiles: type: "boolean"
																									parameters: {
																										items: {
																											properties: {
																												forceString: type: "boolean"
																												name: type: "string"
																												value: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									passCredentials: type: "boolean"
																									releaseName: type: "string"
																									skipCrds: type: "boolean"
																									valueFiles: {
																										items: type: "string"
																										type: "array"
																									}
																									values: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							kustomize: {
																								properties: {
																									commonAnnotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									commonLabels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									forceCommonAnnotations: type: "boolean"
																									forceCommonLabels: type: "boolean"
																									images: {
																										items: type: "string"
																										type: "array"
																									}
																									namePrefix: type: "string"
																									nameSuffix: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							path: type: "string"
																							plugin: {
																								properties: {
																									env: {
																										items: {
																											properties: {
																												name: type: "string"
																												value: type: "string"
																											}
																											required: [
																												"name",
																												"value",
																											]
																											type: "object"
																										}
																										type: "array"
																									}
																									name: type: "string"
																									parameters: {
																										items: {
																											properties: {
																												array: {
																													items: type: "string"
																													type: "array"
																												}
																												map: {
																													additionalProperties: type: "string"
																													type: "object"
																												}
																												name: type: "string"
																												string: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																								}
																								type: "object"
																							}
																							ref: type: "string"
																							repoURL: type: "string"
																							targetRevision: type: "string"
																						}
																						required: ["repoURL"]
																						type: "object"
																					}
																					sources: {
																						items: {
																							properties: {
																								chart: type: "string"
																								directory: {
																									properties: {
																										exclude: type: "string"
																										include: type: "string"
																										jsonnet: {
																											properties: {
																												extVars: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																												libs: {
																													items: type: "string"
																													type: "array"
																												}
																												tlas: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																											}
																											type: "object"
																										}
																										recurse: type: "boolean"
																									}
																									type: "object"
																								}
																								helm: {
																									properties: {
																										fileParameters: {
																											items: {
																												properties: {
																													name: type: "string"
																													path: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										ignoreMissingValueFiles: type: "boolean"
																										parameters: {
																											items: {
																												properties: {
																													forceString: type: "boolean"
																													name: type: "string"
																													value: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										passCredentials: type: "boolean"
																										releaseName: type: "string"
																										skipCrds: type: "boolean"
																										valueFiles: {
																											items: type: "string"
																											type: "array"
																										}
																										values: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								kustomize: {
																									properties: {
																										commonAnnotations: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										commonLabels: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										forceCommonAnnotations: type: "boolean"
																										forceCommonLabels: type: "boolean"
																										images: {
																											items: type: "string"
																											type: "array"
																										}
																										namePrefix: type: "string"
																										nameSuffix: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								path: type: "string"
																								plugin: {
																									properties: {
																										env: {
																											items: {
																												properties: {
																													name: type: "string"
																													value: type: "string"
																												}
																												required: [
																													"name",
																													"value",
																												]
																												type: "object"
																											}
																											type: "array"
																										}
																										name: type: "string"
																										parameters: {
																											items: {
																												properties: {
																													array: {
																														items: type: "string"
																														type: "array"
																													}
																													map: {
																														additionalProperties: type: "string"
																														type: "object"
																													}
																													name: type: "string"
																													string: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																									}
																									type: "object"
																								}
																								ref: type: "string"
																								repoURL: type: "string"
																								targetRevision: type: "string"
																							}
																							required: ["repoURL"]
																							type: "object"
																						}
																						type: "array"
																					}
																					syncPolicy: {
																						properties: {
																							automated: {
																								properties: {
																									allowEmpty: type: "boolean"
																									prune: type: "boolean"
																									selfHeal: type: "boolean"
																								}
																								type: "object"
																							}
																							managedNamespaceMetadata: {
																								properties: {
																									annotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									labels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																								}
																								type: "object"
																							}
																							retry: {
																								properties: {
																									backoff: {
																										properties: {
																											duration: type: "string"
																											factor: {
																												format: "int64"
																												type:   "integer"
																											}
																											maxDuration: type: "string"
																										}
																										type: "object"
																									}
																									limit: {
																										format: "int64"
																										type:   "integer"
																									}
																								}
																								type: "object"
																							}
																							syncOptions: {
																								items: type: "string"
																								type: "array"
																							}
																						}
																						type: "object"
																					}
																				}
																				required: [
																					"destination",
																					"project",
																				]
																				type: "object"
																			}
																		}
																		required: [
																			"metadata",
																			"spec",
																		]
																		type: "object"
																	}
																}
																required: ["elements"]
																type: "object"
															}
															matrix: "x-kubernetes-preserve-unknown-fields": true
															merge: "x-kubernetes-preserve-unknown-fields": true
															pullRequest: {
																properties: {
																	bitbucketServer: {
																		properties: {
																			api: type: "string"
																			basicAuth: {
																				properties: {
																					passwordRef: {
																						properties: {
																							key: type: "string"
																							secretName: type: "string"
																						}
																						required: [
																							"key",
																							"secretName",
																						]
																						type: "object"
																					}
																					username: type: "string"
																				}
																				required: [
																					"passwordRef",
																					"username",
																				]
																				type: "object"
																			}
																			project: type: "string"
																			repo: type: "string"
																		}
																		required: [
																			"api",
																			"project",
																			"repo",
																		]
																		type: "object"
																	}
																	filters: {
																		items: {
																			properties: branchMatch: type: "string"
																			type: "object"
																		}
																		type: "array"
																	}
																	gitea: {
																		properties: {
																			api: type: "string"
																			insecure: type: "boolean"
																			owner: type: "string"
																			repo: type: "string"
																			tokenRef: {
																				properties: {
																					key: type: "string"
																					secretName: type: "string"
																				}
																				required: [
																					"key",
																					"secretName",
																				]
																				type: "object"
																			}
																		}
																		required: [
																			"api",
																			"owner",
																			"repo",
																		]
																		type: "object"
																	}
																	github: {
																		properties: {
																			api: type: "string"
																			appSecretName: type: "string"
																			labels: {
																				items: type: "string"
																				type: "array"
																			}
																			owner: type: "string"
																			repo: type: "string"
																			tokenRef: {
																				properties: {
																					key: type: "string"
																					secretName: type: "string"
																				}
																				required: [
																					"key",
																					"secretName",
																				]
																				type: "object"
																			}
																		}
																		required: [
																			"owner",
																			"repo",
																		]
																		type: "object"
																	}
																	gitlab: {
																		properties: {
																			api: type: "string"
																			labels: {
																				items: type: "string"
																				type: "array"
																			}
																			project: type: "string"
																			pullRequestState: type: "string"
																			tokenRef: {
																				properties: {
																					key: type: "string"
																					secretName: type: "string"
																				}
																				required: [
																					"key",
																					"secretName",
																				]
																				type: "object"
																			}
																		}
																		required: ["project"]
																		type: "object"
																	}
																	requeueAfterSeconds: {
																		format: "int64"
																		type:   "integer"
																	}
																	template: {
																		properties: {
																			metadata: {
																				properties: {
																					annotations: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					finalizers: {
																						items: type: "string"
																						type: "array"
																					}
																					labels: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					name: type: "string"
																					namespace: type: "string"
																				}
																				type: "object"
																			}
																			spec: {
																				properties: {
																					destination: {
																						properties: {
																							name: type: "string"
																							namespace: type: "string"
																							server: type: "string"
																						}
																						type: "object"
																					}
																					ignoreDifferences: {
																						items: {
																							properties: {
																								group: type: "string"
																								jqPathExpressions: {
																									items: type: "string"
																									type: "array"
																								}
																								jsonPointers: {
																									items: type: "string"
																									type: "array"
																								}
																								kind: type: "string"
																								managedFieldsManagers: {
																									items: type: "string"
																									type: "array"
																								}
																								name: type: "string"
																								namespace: type: "string"
																							}
																							required: ["kind"]
																							type: "object"
																						}
																						type: "array"
																					}
																					info: {
																						items: {
																							properties: {
																								name: type: "string"
																								value: type: "string"
																							}
																							required: [
																								"name",
																								"value",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					project: type: "string"
																					revisionHistoryLimit: {
																						format: "int64"
																						type:   "integer"
																					}
																					source: {
																						properties: {
																							chart: type: "string"
																							directory: {
																								properties: {
																									exclude: type: "string"
																									include: type: "string"
																									jsonnet: {
																										properties: {
																											extVars: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																											libs: {
																												items: type: "string"
																												type: "array"
																											}
																											tlas: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																										}
																										type: "object"
																									}
																									recurse: type: "boolean"
																								}
																								type: "object"
																							}
																							helm: {
																								properties: {
																									fileParameters: {
																										items: {
																											properties: {
																												name: type: "string"
																												path: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									ignoreMissingValueFiles: type: "boolean"
																									parameters: {
																										items: {
																											properties: {
																												forceString: type: "boolean"
																												name: type: "string"
																												value: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									passCredentials: type: "boolean"
																									releaseName: type: "string"
																									skipCrds: type: "boolean"
																									valueFiles: {
																										items: type: "string"
																										type: "array"
																									}
																									values: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							kustomize: {
																								properties: {
																									commonAnnotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									commonLabels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									forceCommonAnnotations: type: "boolean"
																									forceCommonLabels: type: "boolean"
																									images: {
																										items: type: "string"
																										type: "array"
																									}
																									namePrefix: type: "string"
																									nameSuffix: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							path: type: "string"
																							plugin: {
																								properties: {
																									env: {
																										items: {
																											properties: {
																												name: type: "string"
																												value: type: "string"
																											}
																											required: [
																												"name",
																												"value",
																											]
																											type: "object"
																										}
																										type: "array"
																									}
																									name: type: "string"
																									parameters: {
																										items: {
																											properties: {
																												array: {
																													items: type: "string"
																													type: "array"
																												}
																												map: {
																													additionalProperties: type: "string"
																													type: "object"
																												}
																												name: type: "string"
																												string: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																								}
																								type: "object"
																							}
																							ref: type: "string"
																							repoURL: type: "string"
																							targetRevision: type: "string"
																						}
																						required: ["repoURL"]
																						type: "object"
																					}
																					sources: {
																						items: {
																							properties: {
																								chart: type: "string"
																								directory: {
																									properties: {
																										exclude: type: "string"
																										include: type: "string"
																										jsonnet: {
																											properties: {
																												extVars: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																												libs: {
																													items: type: "string"
																													type: "array"
																												}
																												tlas: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																											}
																											type: "object"
																										}
																										recurse: type: "boolean"
																									}
																									type: "object"
																								}
																								helm: {
																									properties: {
																										fileParameters: {
																											items: {
																												properties: {
																													name: type: "string"
																													path: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										ignoreMissingValueFiles: type: "boolean"
																										parameters: {
																											items: {
																												properties: {
																													forceString: type: "boolean"
																													name: type: "string"
																													value: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										passCredentials: type: "boolean"
																										releaseName: type: "string"
																										skipCrds: type: "boolean"
																										valueFiles: {
																											items: type: "string"
																											type: "array"
																										}
																										values: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								kustomize: {
																									properties: {
																										commonAnnotations: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										commonLabels: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										forceCommonAnnotations: type: "boolean"
																										forceCommonLabels: type: "boolean"
																										images: {
																											items: type: "string"
																											type: "array"
																										}
																										namePrefix: type: "string"
																										nameSuffix: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								path: type: "string"
																								plugin: {
																									properties: {
																										env: {
																											items: {
																												properties: {
																													name: type: "string"
																													value: type: "string"
																												}
																												required: [
																													"name",
																													"value",
																												]
																												type: "object"
																											}
																											type: "array"
																										}
																										name: type: "string"
																										parameters: {
																											items: {
																												properties: {
																													array: {
																														items: type: "string"
																														type: "array"
																													}
																													map: {
																														additionalProperties: type: "string"
																														type: "object"
																													}
																													name: type: "string"
																													string: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																									}
																									type: "object"
																								}
																								ref: type: "string"
																								repoURL: type: "string"
																								targetRevision: type: "string"
																							}
																							required: ["repoURL"]
																							type: "object"
																						}
																						type: "array"
																					}
																					syncPolicy: {
																						properties: {
																							automated: {
																								properties: {
																									allowEmpty: type: "boolean"
																									prune: type: "boolean"
																									selfHeal: type: "boolean"
																								}
																								type: "object"
																							}
																							managedNamespaceMetadata: {
																								properties: {
																									annotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									labels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																								}
																								type: "object"
																							}
																							retry: {
																								properties: {
																									backoff: {
																										properties: {
																											duration: type: "string"
																											factor: {
																												format: "int64"
																												type:   "integer"
																											}
																											maxDuration: type: "string"
																										}
																										type: "object"
																									}
																									limit: {
																										format: "int64"
																										type:   "integer"
																									}
																								}
																								type: "object"
																							}
																							syncOptions: {
																								items: type: "string"
																								type: "array"
																							}
																						}
																						type: "object"
																					}
																				}
																				required: [
																					"destination",
																					"project",
																				]
																				type: "object"
																			}
																		}
																		required: [
																			"metadata",
																			"spec",
																		]
																		type: "object"
																	}
																}
																type: "object"
															}
															scmProvider: {
																properties: {
																	azureDevOps: {
																		properties: {
																			accessTokenRef: {
																				properties: {
																					key: type: "string"
																					secretName: type: "string"
																				}
																				required: [
																					"key",
																					"secretName",
																				]
																				type: "object"
																			}
																			allBranches: type: "boolean"
																			api: type: "string"
																			organization: type: "string"
																			teamProject: type: "string"
																		}
																		required: [
																			"accessTokenRef",
																			"organization",
																			"teamProject",
																		]
																		type: "object"
																	}
																	bitbucket: {
																		properties: {
																			allBranches: type: "boolean"
																			appPasswordRef: {
																				properties: {
																					key: type: "string"
																					secretName: type: "string"
																				}
																				required: [
																					"key",
																					"secretName",
																				]
																				type: "object"
																			}
																			owner: type: "string"
																			user: type: "string"
																		}
																		required: [
																			"appPasswordRef",
																			"owner",
																			"user",
																		]
																		type: "object"
																	}
																	bitbucketServer: {
																		properties: {
																			allBranches: type: "boolean"
																			api: type: "string"
																			basicAuth: {
																				properties: {
																					passwordRef: {
																						properties: {
																							key: type: "string"
																							secretName: type: "string"
																						}
																						required: [
																							"key",
																							"secretName",
																						]
																						type: "object"
																					}
																					username: type: "string"
																				}
																				required: [
																					"passwordRef",
																					"username",
																				]
																				type: "object"
																			}
																			project: type: "string"
																		}
																		required: [
																			"api",
																			"project",
																		]
																		type: "object"
																	}
																	cloneProtocol: type: "string"
																	filters: {
																		items: {
																			properties: {
																				branchMatch: type: "string"
																				labelMatch: type: "string"
																				pathsDoNotExist: {
																					items: type: "string"
																					type: "array"
																				}
																				pathsExist: {
																					items: type: "string"
																					type: "array"
																				}
																				repositoryMatch: type: "string"
																			}
																			type: "object"
																		}
																		type: "array"
																	}
																	gitea: {
																		properties: {
																			allBranches: type: "boolean"
																			api: type: "string"
																			insecure: type: "boolean"
																			owner: type: "string"
																			tokenRef: {
																				properties: {
																					key: type: "string"
																					secretName: type: "string"
																				}
																				required: [
																					"key",
																					"secretName",
																				]
																				type: "object"
																			}
																		}
																		required: [
																			"api",
																			"owner",
																		]
																		type: "object"
																	}
																	github: {
																		properties: {
																			allBranches: type: "boolean"
																			api: type: "string"
																			appSecretName: type: "string"
																			organization: type: "string"
																			tokenRef: {
																				properties: {
																					key: type: "string"
																					secretName: type: "string"
																				}
																				required: [
																					"key",
																					"secretName",
																				]
																				type: "object"
																			}
																		}
																		required: ["organization"]
																		type: "object"
																	}
																	gitlab: {
																		properties: {
																			allBranches: type: "boolean"
																			api: type: "string"
																			group: type: "string"
																			includeSubgroups: type: "boolean"
																			tokenRef: {
																				properties: {
																					key: type: "string"
																					secretName: type: "string"
																				}
																				required: [
																					"key",
																					"secretName",
																				]
																				type: "object"
																			}
																		}
																		required: ["group"]
																		type: "object"
																	}
																	requeueAfterSeconds: {
																		format: "int64"
																		type:   "integer"
																	}
																	template: {
																		properties: {
																			metadata: {
																				properties: {
																					annotations: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					finalizers: {
																						items: type: "string"
																						type: "array"
																					}
																					labels: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					name: type: "string"
																					namespace: type: "string"
																				}
																				type: "object"
																			}
																			spec: {
																				properties: {
																					destination: {
																						properties: {
																							name: type: "string"
																							namespace: type: "string"
																							server: type: "string"
																						}
																						type: "object"
																					}
																					ignoreDifferences: {
																						items: {
																							properties: {
																								group: type: "string"
																								jqPathExpressions: {
																									items: type: "string"
																									type: "array"
																								}
																								jsonPointers: {
																									items: type: "string"
																									type: "array"
																								}
																								kind: type: "string"
																								managedFieldsManagers: {
																									items: type: "string"
																									type: "array"
																								}
																								name: type: "string"
																								namespace: type: "string"
																							}
																							required: ["kind"]
																							type: "object"
																						}
																						type: "array"
																					}
																					info: {
																						items: {
																							properties: {
																								name: type: "string"
																								value: type: "string"
																							}
																							required: [
																								"name",
																								"value",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					project: type: "string"
																					revisionHistoryLimit: {
																						format: "int64"
																						type:   "integer"
																					}
																					source: {
																						properties: {
																							chart: type: "string"
																							directory: {
																								properties: {
																									exclude: type: "string"
																									include: type: "string"
																									jsonnet: {
																										properties: {
																											extVars: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																											libs: {
																												items: type: "string"
																												type: "array"
																											}
																											tlas: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																										}
																										type: "object"
																									}
																									recurse: type: "boolean"
																								}
																								type: "object"
																							}
																							helm: {
																								properties: {
																									fileParameters: {
																										items: {
																											properties: {
																												name: type: "string"
																												path: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									ignoreMissingValueFiles: type: "boolean"
																									parameters: {
																										items: {
																											properties: {
																												forceString: type: "boolean"
																												name: type: "string"
																												value: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									passCredentials: type: "boolean"
																									releaseName: type: "string"
																									skipCrds: type: "boolean"
																									valueFiles: {
																										items: type: "string"
																										type: "array"
																									}
																									values: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							kustomize: {
																								properties: {
																									commonAnnotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									commonLabels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									forceCommonAnnotations: type: "boolean"
																									forceCommonLabels: type: "boolean"
																									images: {
																										items: type: "string"
																										type: "array"
																									}
																									namePrefix: type: "string"
																									nameSuffix: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							path: type: "string"
																							plugin: {
																								properties: {
																									env: {
																										items: {
																											properties: {
																												name: type: "string"
																												value: type: "string"
																											}
																											required: [
																												"name",
																												"value",
																											]
																											type: "object"
																										}
																										type: "array"
																									}
																									name: type: "string"
																									parameters: {
																										items: {
																											properties: {
																												array: {
																													items: type: "string"
																													type: "array"
																												}
																												map: {
																													additionalProperties: type: "string"
																													type: "object"
																												}
																												name: type: "string"
																												string: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																								}
																								type: "object"
																							}
																							ref: type: "string"
																							repoURL: type: "string"
																							targetRevision: type: "string"
																						}
																						required: ["repoURL"]
																						type: "object"
																					}
																					sources: {
																						items: {
																							properties: {
																								chart: type: "string"
																								directory: {
																									properties: {
																										exclude: type: "string"
																										include: type: "string"
																										jsonnet: {
																											properties: {
																												extVars: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																												libs: {
																													items: type: "string"
																													type: "array"
																												}
																												tlas: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																											}
																											type: "object"
																										}
																										recurse: type: "boolean"
																									}
																									type: "object"
																								}
																								helm: {
																									properties: {
																										fileParameters: {
																											items: {
																												properties: {
																													name: type: "string"
																													path: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										ignoreMissingValueFiles: type: "boolean"
																										parameters: {
																											items: {
																												properties: {
																													forceString: type: "boolean"
																													name: type: "string"
																													value: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										passCredentials: type: "boolean"
																										releaseName: type: "string"
																										skipCrds: type: "boolean"
																										valueFiles: {
																											items: type: "string"
																											type: "array"
																										}
																										values: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								kustomize: {
																									properties: {
																										commonAnnotations: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										commonLabels: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										forceCommonAnnotations: type: "boolean"
																										forceCommonLabels: type: "boolean"
																										images: {
																											items: type: "string"
																											type: "array"
																										}
																										namePrefix: type: "string"
																										nameSuffix: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								path: type: "string"
																								plugin: {
																									properties: {
																										env: {
																											items: {
																												properties: {
																													name: type: "string"
																													value: type: "string"
																												}
																												required: [
																													"name",
																													"value",
																												]
																												type: "object"
																											}
																											type: "array"
																										}
																										name: type: "string"
																										parameters: {
																											items: {
																												properties: {
																													array: {
																														items: type: "string"
																														type: "array"
																													}
																													map: {
																														additionalProperties: type: "string"
																														type: "object"
																													}
																													name: type: "string"
																													string: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																									}
																									type: "object"
																								}
																								ref: type: "string"
																								repoURL: type: "string"
																								targetRevision: type: "string"
																							}
																							required: ["repoURL"]
																							type: "object"
																						}
																						type: "array"
																					}
																					syncPolicy: {
																						properties: {
																							automated: {
																								properties: {
																									allowEmpty: type: "boolean"
																									prune: type: "boolean"
																									selfHeal: type: "boolean"
																								}
																								type: "object"
																							}
																							managedNamespaceMetadata: {
																								properties: {
																									annotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									labels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																								}
																								type: "object"
																							}
																							retry: {
																								properties: {
																									backoff: {
																										properties: {
																											duration: type: "string"
																											factor: {
																												format: "int64"
																												type:   "integer"
																											}
																											maxDuration: type: "string"
																										}
																										type: "object"
																									}
																									limit: {
																										format: "int64"
																										type:   "integer"
																									}
																								}
																								type: "object"
																							}
																							syncOptions: {
																								items: type: "string"
																								type: "array"
																							}
																						}
																						type: "object"
																					}
																				}
																				required: [
																					"destination",
																					"project",
																				]
																				type: "object"
																			}
																		}
																		required: [
																			"metadata",
																			"spec",
																		]
																		type: "object"
																	}
																}
																type: "object"
															}
															selector: {
																properties: {
																	matchExpressions: {
																		items: {
																			properties: {
																				key: type: "string"
																				operator: type: "string"
																				values: {
																					items: type: "string"
																					type: "array"
																				}
																			}
																			required: [
																				"key",
																				"operator",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	matchLabels: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																}
																type: "object"
															}
														}
														type: "object"
													}
													type: "array"
												}
												template: {
													properties: {
														metadata: {
															properties: {
																annotations: {
																	additionalProperties: type: "string"
																	type: "object"
																}
																finalizers: {
																	items: type: "string"
																	type: "array"
																}
																labels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
																name: type: "string"
																namespace: type: "string"
															}
															type: "object"
														}
														spec: {
															properties: {
																destination: {
																	properties: {
																		name: type: "string"
																		namespace: type: "string"
																		server: type: "string"
																	}
																	type: "object"
																}
																ignoreDifferences: {
																	items: {
																		properties: {
																			group: type: "string"
																			jqPathExpressions: {
																				items: type: "string"
																				type: "array"
																			}
																			jsonPointers: {
																				items: type: "string"
																				type: "array"
																			}
																			kind: type: "string"
																			managedFieldsManagers: {
																				items: type: "string"
																				type: "array"
																			}
																			name: type: "string"
																			namespace: type: "string"
																		}
																		required: ["kind"]
																		type: "object"
																	}
																	type: "array"
																}
																info: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																project: type: "string"
																revisionHistoryLimit: {
																	format: "int64"
																	type:   "integer"
																}
																source: {
																	properties: {
																		chart: type: "string"
																		directory: {
																			properties: {
																				exclude: type: "string"
																				include: type: "string"
																				jsonnet: {
																					properties: {
																						extVars: {
																							items: {
																								properties: {
																									code: type: "boolean"
																									name: type: "string"
																									value: type: "string"
																								}
																								required: [
																									"name",
																									"value",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																						libs: {
																							items: type: "string"
																							type: "array"
																						}
																						tlas: {
																							items: {
																								properties: {
																									code: type: "boolean"
																									name: type: "string"
																									value: type: "string"
																								}
																								required: [
																									"name",
																									"value",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																					}
																					type: "object"
																				}
																				recurse: type: "boolean"
																			}
																			type: "object"
																		}
																		helm: {
																			properties: {
																				fileParameters: {
																					items: {
																						properties: {
																							name: type: "string"
																							path: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																				ignoreMissingValueFiles: type: "boolean"
																				parameters: {
																					items: {
																						properties: {
																							forceString: type: "boolean"
																							name: type: "string"
																							value: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																				passCredentials: type: "boolean"
																				releaseName: type: "string"
																				skipCrds: type: "boolean"
																				valueFiles: {
																					items: type: "string"
																					type: "array"
																				}
																				values: type: "string"
																				version: type: "string"
																			}
																			type: "object"
																		}
																		kustomize: {
																			properties: {
																				commonAnnotations: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				commonLabels: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				forceCommonAnnotations: type: "boolean"
																				forceCommonLabels: type: "boolean"
																				images: {
																					items: type: "string"
																					type: "array"
																				}
																				namePrefix: type: "string"
																				nameSuffix: type: "string"
																				version: type: "string"
																			}
																			type: "object"
																		}
																		path: type: "string"
																		plugin: {
																			properties: {
																				env: {
																					items: {
																						properties: {
																							name: type: "string"
																							value: type: "string"
																						}
																						required: [
																							"name",
																							"value",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				name: type: "string"
																				parameters: {
																					items: {
																						properties: {
																							array: {
																								items: type: "string"
																								type: "array"
																							}
																							map: {
																								additionalProperties: type: "string"
																								type: "object"
																							}
																							name: type: "string"
																							string: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																			}
																			type: "object"
																		}
																		ref: type: "string"
																		repoURL: type: "string"
																		targetRevision: type: "string"
																	}
																	required: ["repoURL"]
																	type: "object"
																}
																sources: {
																	items: {
																		properties: {
																			chart: type: "string"
																			directory: {
																				properties: {
																					exclude: type: "string"
																					include: type: "string"
																					jsonnet: {
																						properties: {
																							extVars: {
																								items: {
																									properties: {
																										code: type: "boolean"
																										name: type: "string"
																										value: type: "string"
																									}
																									required: [
																										"name",
																										"value",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																							libs: {
																								items: type: "string"
																								type: "array"
																							}
																							tlas: {
																								items: {
																									properties: {
																										code: type: "boolean"
																										name: type: "string"
																										value: type: "string"
																									}
																									required: [
																										"name",
																										"value",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																						}
																						type: "object"
																					}
																					recurse: type: "boolean"
																				}
																				type: "object"
																			}
																			helm: {
																				properties: {
																					fileParameters: {
																						items: {
																							properties: {
																								name: type: "string"
																								path: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																					ignoreMissingValueFiles: type: "boolean"
																					parameters: {
																						items: {
																							properties: {
																								forceString: type: "boolean"
																								name: type: "string"
																								value: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																					passCredentials: type: "boolean"
																					releaseName: type: "string"
																					skipCrds: type: "boolean"
																					valueFiles: {
																						items: type: "string"
																						type: "array"
																					}
																					values: type: "string"
																					version: type: "string"
																				}
																				type: "object"
																			}
																			kustomize: {
																				properties: {
																					commonAnnotations: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					commonLabels: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					forceCommonAnnotations: type: "boolean"
																					forceCommonLabels: type: "boolean"
																					images: {
																						items: type: "string"
																						type: "array"
																					}
																					namePrefix: type: "string"
																					nameSuffix: type: "string"
																					version: type: "string"
																				}
																				type: "object"
																			}
																			path: type: "string"
																			plugin: {
																				properties: {
																					env: {
																						items: {
																							properties: {
																								name: type: "string"
																								value: type: "string"
																							}
																							required: [
																								"name",
																								"value",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					name: type: "string"
																					parameters: {
																						items: {
																							properties: {
																								array: {
																									items: type: "string"
																									type: "array"
																								}
																								map: {
																									additionalProperties: type: "string"
																									type: "object"
																								}
																								name: type: "string"
																								string: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																				}
																				type: "object"
																			}
																			ref: type: "string"
																			repoURL: type: "string"
																			targetRevision: type: "string"
																		}
																		required: ["repoURL"]
																		type: "object"
																	}
																	type: "array"
																}
																syncPolicy: {
																	properties: {
																		automated: {
																			properties: {
																				allowEmpty: type: "boolean"
																				prune: type: "boolean"
																				selfHeal: type: "boolean"
																			}
																			type: "object"
																		}
																		managedNamespaceMetadata: {
																			properties: {
																				annotations: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				labels: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																			}
																			type: "object"
																		}
																		retry: {
																			properties: {
																				backoff: {
																					properties: {
																						duration: type: "string"
																						factor: {
																							format: "int64"
																							type:   "integer"
																						}
																						maxDuration: type: "string"
																					}
																					type: "object"
																				}
																				limit: {
																					format: "int64"
																					type:   "integer"
																				}
																			}
																			type: "object"
																		}
																		syncOptions: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	type: "object"
																}
															}
															required: [
																"destination",
																"project",
															]
															type: "object"
														}
													}
													required: [
														"metadata",
														"spec",
													]
													type: "object"
												}
											}
											required: ["generators"]
											type: "object"
										}
										merge: {
											properties: {
												generators: {
													items: {
														properties: {
															clusterDecisionResource: {
																properties: {
																	configMapRef: type: "string"
																	labelSelector: {
																		properties: {
																			matchExpressions: {
																				items: {
																					properties: {
																						key: type: "string"
																						operator: type: "string"
																						values: {
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchLabels: {
																				additionalProperties: type: "string"
																				type: "object"
																			}
																		}
																		type: "object"
																	}
																	name: type: "string"
																	requeueAfterSeconds: {
																		format: "int64"
																		type:   "integer"
																	}
																	template: {
																		properties: {
																			metadata: {
																				properties: {
																					annotations: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					finalizers: {
																						items: type: "string"
																						type: "array"
																					}
																					labels: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					name: type: "string"
																					namespace: type: "string"
																				}
																				type: "object"
																			}
																			spec: {
																				properties: {
																					destination: {
																						properties: {
																							name: type: "string"
																							namespace: type: "string"
																							server: type: "string"
																						}
																						type: "object"
																					}
																					ignoreDifferences: {
																						items: {
																							properties: {
																								group: type: "string"
																								jqPathExpressions: {
																									items: type: "string"
																									type: "array"
																								}
																								jsonPointers: {
																									items: type: "string"
																									type: "array"
																								}
																								kind: type: "string"
																								managedFieldsManagers: {
																									items: type: "string"
																									type: "array"
																								}
																								name: type: "string"
																								namespace: type: "string"
																							}
																							required: ["kind"]
																							type: "object"
																						}
																						type: "array"
																					}
																					info: {
																						items: {
																							properties: {
																								name: type: "string"
																								value: type: "string"
																							}
																							required: [
																								"name",
																								"value",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					project: type: "string"
																					revisionHistoryLimit: {
																						format: "int64"
																						type:   "integer"
																					}
																					source: {
																						properties: {
																							chart: type: "string"
																							directory: {
																								properties: {
																									exclude: type: "string"
																									include: type: "string"
																									jsonnet: {
																										properties: {
																											extVars: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																											libs: {
																												items: type: "string"
																												type: "array"
																											}
																											tlas: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																										}
																										type: "object"
																									}
																									recurse: type: "boolean"
																								}
																								type: "object"
																							}
																							helm: {
																								properties: {
																									fileParameters: {
																										items: {
																											properties: {
																												name: type: "string"
																												path: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									ignoreMissingValueFiles: type: "boolean"
																									parameters: {
																										items: {
																											properties: {
																												forceString: type: "boolean"
																												name: type: "string"
																												value: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									passCredentials: type: "boolean"
																									releaseName: type: "string"
																									skipCrds: type: "boolean"
																									valueFiles: {
																										items: type: "string"
																										type: "array"
																									}
																									values: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							kustomize: {
																								properties: {
																									commonAnnotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									commonLabels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									forceCommonAnnotations: type: "boolean"
																									forceCommonLabels: type: "boolean"
																									images: {
																										items: type: "string"
																										type: "array"
																									}
																									namePrefix: type: "string"
																									nameSuffix: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							path: type: "string"
																							plugin: {
																								properties: {
																									env: {
																										items: {
																											properties: {
																												name: type: "string"
																												value: type: "string"
																											}
																											required: [
																												"name",
																												"value",
																											]
																											type: "object"
																										}
																										type: "array"
																									}
																									name: type: "string"
																									parameters: {
																										items: {
																											properties: {
																												array: {
																													items: type: "string"
																													type: "array"
																												}
																												map: {
																													additionalProperties: type: "string"
																													type: "object"
																												}
																												name: type: "string"
																												string: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																								}
																								type: "object"
																							}
																							ref: type: "string"
																							repoURL: type: "string"
																							targetRevision: type: "string"
																						}
																						required: ["repoURL"]
																						type: "object"
																					}
																					sources: {
																						items: {
																							properties: {
																								chart: type: "string"
																								directory: {
																									properties: {
																										exclude: type: "string"
																										include: type: "string"
																										jsonnet: {
																											properties: {
																												extVars: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																												libs: {
																													items: type: "string"
																													type: "array"
																												}
																												tlas: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																											}
																											type: "object"
																										}
																										recurse: type: "boolean"
																									}
																									type: "object"
																								}
																								helm: {
																									properties: {
																										fileParameters: {
																											items: {
																												properties: {
																													name: type: "string"
																													path: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										ignoreMissingValueFiles: type: "boolean"
																										parameters: {
																											items: {
																												properties: {
																													forceString: type: "boolean"
																													name: type: "string"
																													value: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										passCredentials: type: "boolean"
																										releaseName: type: "string"
																										skipCrds: type: "boolean"
																										valueFiles: {
																											items: type: "string"
																											type: "array"
																										}
																										values: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								kustomize: {
																									properties: {
																										commonAnnotations: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										commonLabels: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										forceCommonAnnotations: type: "boolean"
																										forceCommonLabels: type: "boolean"
																										images: {
																											items: type: "string"
																											type: "array"
																										}
																										namePrefix: type: "string"
																										nameSuffix: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								path: type: "string"
																								plugin: {
																									properties: {
																										env: {
																											items: {
																												properties: {
																													name: type: "string"
																													value: type: "string"
																												}
																												required: [
																													"name",
																													"value",
																												]
																												type: "object"
																											}
																											type: "array"
																										}
																										name: type: "string"
																										parameters: {
																											items: {
																												properties: {
																													array: {
																														items: type: "string"
																														type: "array"
																													}
																													map: {
																														additionalProperties: type: "string"
																														type: "object"
																													}
																													name: type: "string"
																													string: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																									}
																									type: "object"
																								}
																								ref: type: "string"
																								repoURL: type: "string"
																								targetRevision: type: "string"
																							}
																							required: ["repoURL"]
																							type: "object"
																						}
																						type: "array"
																					}
																					syncPolicy: {
																						properties: {
																							automated: {
																								properties: {
																									allowEmpty: type: "boolean"
																									prune: type: "boolean"
																									selfHeal: type: "boolean"
																								}
																								type: "object"
																							}
																							managedNamespaceMetadata: {
																								properties: {
																									annotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									labels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																								}
																								type: "object"
																							}
																							retry: {
																								properties: {
																									backoff: {
																										properties: {
																											duration: type: "string"
																											factor: {
																												format: "int64"
																												type:   "integer"
																											}
																											maxDuration: type: "string"
																										}
																										type: "object"
																									}
																									limit: {
																										format: "int64"
																										type:   "integer"
																									}
																								}
																								type: "object"
																							}
																							syncOptions: {
																								items: type: "string"
																								type: "array"
																							}
																						}
																						type: "object"
																					}
																				}
																				required: [
																					"destination",
																					"project",
																				]
																				type: "object"
																			}
																		}
																		required: [
																			"metadata",
																			"spec",
																		]
																		type: "object"
																	}
																	values: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																}
																required: ["configMapRef"]
																type: "object"
															}
															clusters: {
																properties: {
																	selector: {
																		properties: {
																			matchExpressions: {
																				items: {
																					properties: {
																						key: type: "string"
																						operator: type: "string"
																						values: {
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchLabels: {
																				additionalProperties: type: "string"
																				type: "object"
																			}
																		}
																		type: "object"
																	}
																	template: {
																		properties: {
																			metadata: {
																				properties: {
																					annotations: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					finalizers: {
																						items: type: "string"
																						type: "array"
																					}
																					labels: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					name: type: "string"
																					namespace: type: "string"
																				}
																				type: "object"
																			}
																			spec: {
																				properties: {
																					destination: {
																						properties: {
																							name: type: "string"
																							namespace: type: "string"
																							server: type: "string"
																						}
																						type: "object"
																					}
																					ignoreDifferences: {
																						items: {
																							properties: {
																								group: type: "string"
																								jqPathExpressions: {
																									items: type: "string"
																									type: "array"
																								}
																								jsonPointers: {
																									items: type: "string"
																									type: "array"
																								}
																								kind: type: "string"
																								managedFieldsManagers: {
																									items: type: "string"
																									type: "array"
																								}
																								name: type: "string"
																								namespace: type: "string"
																							}
																							required: ["kind"]
																							type: "object"
																						}
																						type: "array"
																					}
																					info: {
																						items: {
																							properties: {
																								name: type: "string"
																								value: type: "string"
																							}
																							required: [
																								"name",
																								"value",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					project: type: "string"
																					revisionHistoryLimit: {
																						format: "int64"
																						type:   "integer"
																					}
																					source: {
																						properties: {
																							chart: type: "string"
																							directory: {
																								properties: {
																									exclude: type: "string"
																									include: type: "string"
																									jsonnet: {
																										properties: {
																											extVars: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																											libs: {
																												items: type: "string"
																												type: "array"
																											}
																											tlas: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																										}
																										type: "object"
																									}
																									recurse: type: "boolean"
																								}
																								type: "object"
																							}
																							helm: {
																								properties: {
																									fileParameters: {
																										items: {
																											properties: {
																												name: type: "string"
																												path: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									ignoreMissingValueFiles: type: "boolean"
																									parameters: {
																										items: {
																											properties: {
																												forceString: type: "boolean"
																												name: type: "string"
																												value: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									passCredentials: type: "boolean"
																									releaseName: type: "string"
																									skipCrds: type: "boolean"
																									valueFiles: {
																										items: type: "string"
																										type: "array"
																									}
																									values: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							kustomize: {
																								properties: {
																									commonAnnotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									commonLabels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									forceCommonAnnotations: type: "boolean"
																									forceCommonLabels: type: "boolean"
																									images: {
																										items: type: "string"
																										type: "array"
																									}
																									namePrefix: type: "string"
																									nameSuffix: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							path: type: "string"
																							plugin: {
																								properties: {
																									env: {
																										items: {
																											properties: {
																												name: type: "string"
																												value: type: "string"
																											}
																											required: [
																												"name",
																												"value",
																											]
																											type: "object"
																										}
																										type: "array"
																									}
																									name: type: "string"
																									parameters: {
																										items: {
																											properties: {
																												array: {
																													items: type: "string"
																													type: "array"
																												}
																												map: {
																													additionalProperties: type: "string"
																													type: "object"
																												}
																												name: type: "string"
																												string: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																								}
																								type: "object"
																							}
																							ref: type: "string"
																							repoURL: type: "string"
																							targetRevision: type: "string"
																						}
																						required: ["repoURL"]
																						type: "object"
																					}
																					sources: {
																						items: {
																							properties: {
																								chart: type: "string"
																								directory: {
																									properties: {
																										exclude: type: "string"
																										include: type: "string"
																										jsonnet: {
																											properties: {
																												extVars: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																												libs: {
																													items: type: "string"
																													type: "array"
																												}
																												tlas: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																											}
																											type: "object"
																										}
																										recurse: type: "boolean"
																									}
																									type: "object"
																								}
																								helm: {
																									properties: {
																										fileParameters: {
																											items: {
																												properties: {
																													name: type: "string"
																													path: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										ignoreMissingValueFiles: type: "boolean"
																										parameters: {
																											items: {
																												properties: {
																													forceString: type: "boolean"
																													name: type: "string"
																													value: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										passCredentials: type: "boolean"
																										releaseName: type: "string"
																										skipCrds: type: "boolean"
																										valueFiles: {
																											items: type: "string"
																											type: "array"
																										}
																										values: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								kustomize: {
																									properties: {
																										commonAnnotations: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										commonLabels: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										forceCommonAnnotations: type: "boolean"
																										forceCommonLabels: type: "boolean"
																										images: {
																											items: type: "string"
																											type: "array"
																										}
																										namePrefix: type: "string"
																										nameSuffix: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								path: type: "string"
																								plugin: {
																									properties: {
																										env: {
																											items: {
																												properties: {
																													name: type: "string"
																													value: type: "string"
																												}
																												required: [
																													"name",
																													"value",
																												]
																												type: "object"
																											}
																											type: "array"
																										}
																										name: type: "string"
																										parameters: {
																											items: {
																												properties: {
																													array: {
																														items: type: "string"
																														type: "array"
																													}
																													map: {
																														additionalProperties: type: "string"
																														type: "object"
																													}
																													name: type: "string"
																													string: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																									}
																									type: "object"
																								}
																								ref: type: "string"
																								repoURL: type: "string"
																								targetRevision: type: "string"
																							}
																							required: ["repoURL"]
																							type: "object"
																						}
																						type: "array"
																					}
																					syncPolicy: {
																						properties: {
																							automated: {
																								properties: {
																									allowEmpty: type: "boolean"
																									prune: type: "boolean"
																									selfHeal: type: "boolean"
																								}
																								type: "object"
																							}
																							managedNamespaceMetadata: {
																								properties: {
																									annotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									labels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																								}
																								type: "object"
																							}
																							retry: {
																								properties: {
																									backoff: {
																										properties: {
																											duration: type: "string"
																											factor: {
																												format: "int64"
																												type:   "integer"
																											}
																											maxDuration: type: "string"
																										}
																										type: "object"
																									}
																									limit: {
																										format: "int64"
																										type:   "integer"
																									}
																								}
																								type: "object"
																							}
																							syncOptions: {
																								items: type: "string"
																								type: "array"
																							}
																						}
																						type: "object"
																					}
																				}
																				required: [
																					"destination",
																					"project",
																				]
																				type: "object"
																			}
																		}
																		required: [
																			"metadata",
																			"spec",
																		]
																		type: "object"
																	}
																	values: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																}
																type: "object"
															}
															git: {
																properties: {
																	directories: {
																		items: {
																			properties: {
																				exclude: type: "boolean"
																				path: type: "string"
																			}
																			required: ["path"]
																			type: "object"
																		}
																		type: "array"
																	}
																	files: {
																		items: {
																			properties: path: type: "string"
																			required: ["path"]
																			type: "object"
																		}
																		type: "array"
																	}
																	pathParamPrefix: type: "string"
																	repoURL: type: "string"
																	requeueAfterSeconds: {
																		format: "int64"
																		type:   "integer"
																	}
																	revision: type: "string"
																	template: {
																		properties: {
																			metadata: {
																				properties: {
																					annotations: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					finalizers: {
																						items: type: "string"
																						type: "array"
																					}
																					labels: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					name: type: "string"
																					namespace: type: "string"
																				}
																				type: "object"
																			}
																			spec: {
																				properties: {
																					destination: {
																						properties: {
																							name: type: "string"
																							namespace: type: "string"
																							server: type: "string"
																						}
																						type: "object"
																					}
																					ignoreDifferences: {
																						items: {
																							properties: {
																								group: type: "string"
																								jqPathExpressions: {
																									items: type: "string"
																									type: "array"
																								}
																								jsonPointers: {
																									items: type: "string"
																									type: "array"
																								}
																								kind: type: "string"
																								managedFieldsManagers: {
																									items: type: "string"
																									type: "array"
																								}
																								name: type: "string"
																								namespace: type: "string"
																							}
																							required: ["kind"]
																							type: "object"
																						}
																						type: "array"
																					}
																					info: {
																						items: {
																							properties: {
																								name: type: "string"
																								value: type: "string"
																							}
																							required: [
																								"name",
																								"value",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					project: type: "string"
																					revisionHistoryLimit: {
																						format: "int64"
																						type:   "integer"
																					}
																					source: {
																						properties: {
																							chart: type: "string"
																							directory: {
																								properties: {
																									exclude: type: "string"
																									include: type: "string"
																									jsonnet: {
																										properties: {
																											extVars: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																											libs: {
																												items: type: "string"
																												type: "array"
																											}
																											tlas: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																										}
																										type: "object"
																									}
																									recurse: type: "boolean"
																								}
																								type: "object"
																							}
																							helm: {
																								properties: {
																									fileParameters: {
																										items: {
																											properties: {
																												name: type: "string"
																												path: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									ignoreMissingValueFiles: type: "boolean"
																									parameters: {
																										items: {
																											properties: {
																												forceString: type: "boolean"
																												name: type: "string"
																												value: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									passCredentials: type: "boolean"
																									releaseName: type: "string"
																									skipCrds: type: "boolean"
																									valueFiles: {
																										items: type: "string"
																										type: "array"
																									}
																									values: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							kustomize: {
																								properties: {
																									commonAnnotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									commonLabels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									forceCommonAnnotations: type: "boolean"
																									forceCommonLabels: type: "boolean"
																									images: {
																										items: type: "string"
																										type: "array"
																									}
																									namePrefix: type: "string"
																									nameSuffix: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							path: type: "string"
																							plugin: {
																								properties: {
																									env: {
																										items: {
																											properties: {
																												name: type: "string"
																												value: type: "string"
																											}
																											required: [
																												"name",
																												"value",
																											]
																											type: "object"
																										}
																										type: "array"
																									}
																									name: type: "string"
																									parameters: {
																										items: {
																											properties: {
																												array: {
																													items: type: "string"
																													type: "array"
																												}
																												map: {
																													additionalProperties: type: "string"
																													type: "object"
																												}
																												name: type: "string"
																												string: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																								}
																								type: "object"
																							}
																							ref: type: "string"
																							repoURL: type: "string"
																							targetRevision: type: "string"
																						}
																						required: ["repoURL"]
																						type: "object"
																					}
																					sources: {
																						items: {
																							properties: {
																								chart: type: "string"
																								directory: {
																									properties: {
																										exclude: type: "string"
																										include: type: "string"
																										jsonnet: {
																											properties: {
																												extVars: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																												libs: {
																													items: type: "string"
																													type: "array"
																												}
																												tlas: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																											}
																											type: "object"
																										}
																										recurse: type: "boolean"
																									}
																									type: "object"
																								}
																								helm: {
																									properties: {
																										fileParameters: {
																											items: {
																												properties: {
																													name: type: "string"
																													path: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										ignoreMissingValueFiles: type: "boolean"
																										parameters: {
																											items: {
																												properties: {
																													forceString: type: "boolean"
																													name: type: "string"
																													value: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										passCredentials: type: "boolean"
																										releaseName: type: "string"
																										skipCrds: type: "boolean"
																										valueFiles: {
																											items: type: "string"
																											type: "array"
																										}
																										values: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								kustomize: {
																									properties: {
																										commonAnnotations: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										commonLabels: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										forceCommonAnnotations: type: "boolean"
																										forceCommonLabels: type: "boolean"
																										images: {
																											items: type: "string"
																											type: "array"
																										}
																										namePrefix: type: "string"
																										nameSuffix: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								path: type: "string"
																								plugin: {
																									properties: {
																										env: {
																											items: {
																												properties: {
																													name: type: "string"
																													value: type: "string"
																												}
																												required: [
																													"name",
																													"value",
																												]
																												type: "object"
																											}
																											type: "array"
																										}
																										name: type: "string"
																										parameters: {
																											items: {
																												properties: {
																													array: {
																														items: type: "string"
																														type: "array"
																													}
																													map: {
																														additionalProperties: type: "string"
																														type: "object"
																													}
																													name: type: "string"
																													string: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																									}
																									type: "object"
																								}
																								ref: type: "string"
																								repoURL: type: "string"
																								targetRevision: type: "string"
																							}
																							required: ["repoURL"]
																							type: "object"
																						}
																						type: "array"
																					}
																					syncPolicy: {
																						properties: {
																							automated: {
																								properties: {
																									allowEmpty: type: "boolean"
																									prune: type: "boolean"
																									selfHeal: type: "boolean"
																								}
																								type: "object"
																							}
																							managedNamespaceMetadata: {
																								properties: {
																									annotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									labels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																								}
																								type: "object"
																							}
																							retry: {
																								properties: {
																									backoff: {
																										properties: {
																											duration: type: "string"
																											factor: {
																												format: "int64"
																												type:   "integer"
																											}
																											maxDuration: type: "string"
																										}
																										type: "object"
																									}
																									limit: {
																										format: "int64"
																										type:   "integer"
																									}
																								}
																								type: "object"
																							}
																							syncOptions: {
																								items: type: "string"
																								type: "array"
																							}
																						}
																						type: "object"
																					}
																				}
																				required: [
																					"destination",
																					"project",
																				]
																				type: "object"
																			}
																		}
																		required: [
																			"metadata",
																			"spec",
																		]
																		type: "object"
																	}
																}
																required: [
																	"repoURL",
																	"revision",
																]
																type: "object"
															}
															list: {
																properties: {
																	elements: {
																		items: "x-kubernetes-preserve-unknown-fields": true
																		type: "array"
																	}
																	template: {
																		properties: {
																			metadata: {
																				properties: {
																					annotations: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					finalizers: {
																						items: type: "string"
																						type: "array"
																					}
																					labels: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					name: type: "string"
																					namespace: type: "string"
																				}
																				type: "object"
																			}
																			spec: {
																				properties: {
																					destination: {
																						properties: {
																							name: type: "string"
																							namespace: type: "string"
																							server: type: "string"
																						}
																						type: "object"
																					}
																					ignoreDifferences: {
																						items: {
																							properties: {
																								group: type: "string"
																								jqPathExpressions: {
																									items: type: "string"
																									type: "array"
																								}
																								jsonPointers: {
																									items: type: "string"
																									type: "array"
																								}
																								kind: type: "string"
																								managedFieldsManagers: {
																									items: type: "string"
																									type: "array"
																								}
																								name: type: "string"
																								namespace: type: "string"
																							}
																							required: ["kind"]
																							type: "object"
																						}
																						type: "array"
																					}
																					info: {
																						items: {
																							properties: {
																								name: type: "string"
																								value: type: "string"
																							}
																							required: [
																								"name",
																								"value",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					project: type: "string"
																					revisionHistoryLimit: {
																						format: "int64"
																						type:   "integer"
																					}
																					source: {
																						properties: {
																							chart: type: "string"
																							directory: {
																								properties: {
																									exclude: type: "string"
																									include: type: "string"
																									jsonnet: {
																										properties: {
																											extVars: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																											libs: {
																												items: type: "string"
																												type: "array"
																											}
																											tlas: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																										}
																										type: "object"
																									}
																									recurse: type: "boolean"
																								}
																								type: "object"
																							}
																							helm: {
																								properties: {
																									fileParameters: {
																										items: {
																											properties: {
																												name: type: "string"
																												path: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									ignoreMissingValueFiles: type: "boolean"
																									parameters: {
																										items: {
																											properties: {
																												forceString: type: "boolean"
																												name: type: "string"
																												value: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									passCredentials: type: "boolean"
																									releaseName: type: "string"
																									skipCrds: type: "boolean"
																									valueFiles: {
																										items: type: "string"
																										type: "array"
																									}
																									values: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							kustomize: {
																								properties: {
																									commonAnnotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									commonLabels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									forceCommonAnnotations: type: "boolean"
																									forceCommonLabels: type: "boolean"
																									images: {
																										items: type: "string"
																										type: "array"
																									}
																									namePrefix: type: "string"
																									nameSuffix: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							path: type: "string"
																							plugin: {
																								properties: {
																									env: {
																										items: {
																											properties: {
																												name: type: "string"
																												value: type: "string"
																											}
																											required: [
																												"name",
																												"value",
																											]
																											type: "object"
																										}
																										type: "array"
																									}
																									name: type: "string"
																									parameters: {
																										items: {
																											properties: {
																												array: {
																													items: type: "string"
																													type: "array"
																												}
																												map: {
																													additionalProperties: type: "string"
																													type: "object"
																												}
																												name: type: "string"
																												string: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																								}
																								type: "object"
																							}
																							ref: type: "string"
																							repoURL: type: "string"
																							targetRevision: type: "string"
																						}
																						required: ["repoURL"]
																						type: "object"
																					}
																					sources: {
																						items: {
																							properties: {
																								chart: type: "string"
																								directory: {
																									properties: {
																										exclude: type: "string"
																										include: type: "string"
																										jsonnet: {
																											properties: {
																												extVars: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																												libs: {
																													items: type: "string"
																													type: "array"
																												}
																												tlas: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																											}
																											type: "object"
																										}
																										recurse: type: "boolean"
																									}
																									type: "object"
																								}
																								helm: {
																									properties: {
																										fileParameters: {
																											items: {
																												properties: {
																													name: type: "string"
																													path: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										ignoreMissingValueFiles: type: "boolean"
																										parameters: {
																											items: {
																												properties: {
																													forceString: type: "boolean"
																													name: type: "string"
																													value: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										passCredentials: type: "boolean"
																										releaseName: type: "string"
																										skipCrds: type: "boolean"
																										valueFiles: {
																											items: type: "string"
																											type: "array"
																										}
																										values: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								kustomize: {
																									properties: {
																										commonAnnotations: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										commonLabels: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										forceCommonAnnotations: type: "boolean"
																										forceCommonLabels: type: "boolean"
																										images: {
																											items: type: "string"
																											type: "array"
																										}
																										namePrefix: type: "string"
																										nameSuffix: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								path: type: "string"
																								plugin: {
																									properties: {
																										env: {
																											items: {
																												properties: {
																													name: type: "string"
																													value: type: "string"
																												}
																												required: [
																													"name",
																													"value",
																												]
																												type: "object"
																											}
																											type: "array"
																										}
																										name: type: "string"
																										parameters: {
																											items: {
																												properties: {
																													array: {
																														items: type: "string"
																														type: "array"
																													}
																													map: {
																														additionalProperties: type: "string"
																														type: "object"
																													}
																													name: type: "string"
																													string: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																									}
																									type: "object"
																								}
																								ref: type: "string"
																								repoURL: type: "string"
																								targetRevision: type: "string"
																							}
																							required: ["repoURL"]
																							type: "object"
																						}
																						type: "array"
																					}
																					syncPolicy: {
																						properties: {
																							automated: {
																								properties: {
																									allowEmpty: type: "boolean"
																									prune: type: "boolean"
																									selfHeal: type: "boolean"
																								}
																								type: "object"
																							}
																							managedNamespaceMetadata: {
																								properties: {
																									annotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									labels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																								}
																								type: "object"
																							}
																							retry: {
																								properties: {
																									backoff: {
																										properties: {
																											duration: type: "string"
																											factor: {
																												format: "int64"
																												type:   "integer"
																											}
																											maxDuration: type: "string"
																										}
																										type: "object"
																									}
																									limit: {
																										format: "int64"
																										type:   "integer"
																									}
																								}
																								type: "object"
																							}
																							syncOptions: {
																								items: type: "string"
																								type: "array"
																							}
																						}
																						type: "object"
																					}
																				}
																				required: [
																					"destination",
																					"project",
																				]
																				type: "object"
																			}
																		}
																		required: [
																			"metadata",
																			"spec",
																		]
																		type: "object"
																	}
																}
																required: ["elements"]
																type: "object"
															}
															matrix: "x-kubernetes-preserve-unknown-fields": true
															merge: "x-kubernetes-preserve-unknown-fields": true
															pullRequest: {
																properties: {
																	bitbucketServer: {
																		properties: {
																			api: type: "string"
																			basicAuth: {
																				properties: {
																					passwordRef: {
																						properties: {
																							key: type: "string"
																							secretName: type: "string"
																						}
																						required: [
																							"key",
																							"secretName",
																						]
																						type: "object"
																					}
																					username: type: "string"
																				}
																				required: [
																					"passwordRef",
																					"username",
																				]
																				type: "object"
																			}
																			project: type: "string"
																			repo: type: "string"
																		}
																		required: [
																			"api",
																			"project",
																			"repo",
																		]
																		type: "object"
																	}
																	filters: {
																		items: {
																			properties: branchMatch: type: "string"
																			type: "object"
																		}
																		type: "array"
																	}
																	gitea: {
																		properties: {
																			api: type: "string"
																			insecure: type: "boolean"
																			owner: type: "string"
																			repo: type: "string"
																			tokenRef: {
																				properties: {
																					key: type: "string"
																					secretName: type: "string"
																				}
																				required: [
																					"key",
																					"secretName",
																				]
																				type: "object"
																			}
																		}
																		required: [
																			"api",
																			"owner",
																			"repo",
																		]
																		type: "object"
																	}
																	github: {
																		properties: {
																			api: type: "string"
																			appSecretName: type: "string"
																			labels: {
																				items: type: "string"
																				type: "array"
																			}
																			owner: type: "string"
																			repo: type: "string"
																			tokenRef: {
																				properties: {
																					key: type: "string"
																					secretName: type: "string"
																				}
																				required: [
																					"key",
																					"secretName",
																				]
																				type: "object"
																			}
																		}
																		required: [
																			"owner",
																			"repo",
																		]
																		type: "object"
																	}
																	gitlab: {
																		properties: {
																			api: type: "string"
																			labels: {
																				items: type: "string"
																				type: "array"
																			}
																			project: type: "string"
																			pullRequestState: type: "string"
																			tokenRef: {
																				properties: {
																					key: type: "string"
																					secretName: type: "string"
																				}
																				required: [
																					"key",
																					"secretName",
																				]
																				type: "object"
																			}
																		}
																		required: ["project"]
																		type: "object"
																	}
																	requeueAfterSeconds: {
																		format: "int64"
																		type:   "integer"
																	}
																	template: {
																		properties: {
																			metadata: {
																				properties: {
																					annotations: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					finalizers: {
																						items: type: "string"
																						type: "array"
																					}
																					labels: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					name: type: "string"
																					namespace: type: "string"
																				}
																				type: "object"
																			}
																			spec: {
																				properties: {
																					destination: {
																						properties: {
																							name: type: "string"
																							namespace: type: "string"
																							server: type: "string"
																						}
																						type: "object"
																					}
																					ignoreDifferences: {
																						items: {
																							properties: {
																								group: type: "string"
																								jqPathExpressions: {
																									items: type: "string"
																									type: "array"
																								}
																								jsonPointers: {
																									items: type: "string"
																									type: "array"
																								}
																								kind: type: "string"
																								managedFieldsManagers: {
																									items: type: "string"
																									type: "array"
																								}
																								name: type: "string"
																								namespace: type: "string"
																							}
																							required: ["kind"]
																							type: "object"
																						}
																						type: "array"
																					}
																					info: {
																						items: {
																							properties: {
																								name: type: "string"
																								value: type: "string"
																							}
																							required: [
																								"name",
																								"value",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					project: type: "string"
																					revisionHistoryLimit: {
																						format: "int64"
																						type:   "integer"
																					}
																					source: {
																						properties: {
																							chart: type: "string"
																							directory: {
																								properties: {
																									exclude: type: "string"
																									include: type: "string"
																									jsonnet: {
																										properties: {
																											extVars: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																											libs: {
																												items: type: "string"
																												type: "array"
																											}
																											tlas: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																										}
																										type: "object"
																									}
																									recurse: type: "boolean"
																								}
																								type: "object"
																							}
																							helm: {
																								properties: {
																									fileParameters: {
																										items: {
																											properties: {
																												name: type: "string"
																												path: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									ignoreMissingValueFiles: type: "boolean"
																									parameters: {
																										items: {
																											properties: {
																												forceString: type: "boolean"
																												name: type: "string"
																												value: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									passCredentials: type: "boolean"
																									releaseName: type: "string"
																									skipCrds: type: "boolean"
																									valueFiles: {
																										items: type: "string"
																										type: "array"
																									}
																									values: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							kustomize: {
																								properties: {
																									commonAnnotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									commonLabels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									forceCommonAnnotations: type: "boolean"
																									forceCommonLabels: type: "boolean"
																									images: {
																										items: type: "string"
																										type: "array"
																									}
																									namePrefix: type: "string"
																									nameSuffix: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							path: type: "string"
																							plugin: {
																								properties: {
																									env: {
																										items: {
																											properties: {
																												name: type: "string"
																												value: type: "string"
																											}
																											required: [
																												"name",
																												"value",
																											]
																											type: "object"
																										}
																										type: "array"
																									}
																									name: type: "string"
																									parameters: {
																										items: {
																											properties: {
																												array: {
																													items: type: "string"
																													type: "array"
																												}
																												map: {
																													additionalProperties: type: "string"
																													type: "object"
																												}
																												name: type: "string"
																												string: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																								}
																								type: "object"
																							}
																							ref: type: "string"
																							repoURL: type: "string"
																							targetRevision: type: "string"
																						}
																						required: ["repoURL"]
																						type: "object"
																					}
																					sources: {
																						items: {
																							properties: {
																								chart: type: "string"
																								directory: {
																									properties: {
																										exclude: type: "string"
																										include: type: "string"
																										jsonnet: {
																											properties: {
																												extVars: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																												libs: {
																													items: type: "string"
																													type: "array"
																												}
																												tlas: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																											}
																											type: "object"
																										}
																										recurse: type: "boolean"
																									}
																									type: "object"
																								}
																								helm: {
																									properties: {
																										fileParameters: {
																											items: {
																												properties: {
																													name: type: "string"
																													path: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										ignoreMissingValueFiles: type: "boolean"
																										parameters: {
																											items: {
																												properties: {
																													forceString: type: "boolean"
																													name: type: "string"
																													value: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										passCredentials: type: "boolean"
																										releaseName: type: "string"
																										skipCrds: type: "boolean"
																										valueFiles: {
																											items: type: "string"
																											type: "array"
																										}
																										values: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								kustomize: {
																									properties: {
																										commonAnnotations: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										commonLabels: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										forceCommonAnnotations: type: "boolean"
																										forceCommonLabels: type: "boolean"
																										images: {
																											items: type: "string"
																											type: "array"
																										}
																										namePrefix: type: "string"
																										nameSuffix: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								path: type: "string"
																								plugin: {
																									properties: {
																										env: {
																											items: {
																												properties: {
																													name: type: "string"
																													value: type: "string"
																												}
																												required: [
																													"name",
																													"value",
																												]
																												type: "object"
																											}
																											type: "array"
																										}
																										name: type: "string"
																										parameters: {
																											items: {
																												properties: {
																													array: {
																														items: type: "string"
																														type: "array"
																													}
																													map: {
																														additionalProperties: type: "string"
																														type: "object"
																													}
																													name: type: "string"
																													string: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																									}
																									type: "object"
																								}
																								ref: type: "string"
																								repoURL: type: "string"
																								targetRevision: type: "string"
																							}
																							required: ["repoURL"]
																							type: "object"
																						}
																						type: "array"
																					}
																					syncPolicy: {
																						properties: {
																							automated: {
																								properties: {
																									allowEmpty: type: "boolean"
																									prune: type: "boolean"
																									selfHeal: type: "boolean"
																								}
																								type: "object"
																							}
																							managedNamespaceMetadata: {
																								properties: {
																									annotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									labels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																								}
																								type: "object"
																							}
																							retry: {
																								properties: {
																									backoff: {
																										properties: {
																											duration: type: "string"
																											factor: {
																												format: "int64"
																												type:   "integer"
																											}
																											maxDuration: type: "string"
																										}
																										type: "object"
																									}
																									limit: {
																										format: "int64"
																										type:   "integer"
																									}
																								}
																								type: "object"
																							}
																							syncOptions: {
																								items: type: "string"
																								type: "array"
																							}
																						}
																						type: "object"
																					}
																				}
																				required: [
																					"destination",
																					"project",
																				]
																				type: "object"
																			}
																		}
																		required: [
																			"metadata",
																			"spec",
																		]
																		type: "object"
																	}
																}
																type: "object"
															}
															scmProvider: {
																properties: {
																	azureDevOps: {
																		properties: {
																			accessTokenRef: {
																				properties: {
																					key: type: "string"
																					secretName: type: "string"
																				}
																				required: [
																					"key",
																					"secretName",
																				]
																				type: "object"
																			}
																			allBranches: type: "boolean"
																			api: type: "string"
																			organization: type: "string"
																			teamProject: type: "string"
																		}
																		required: [
																			"accessTokenRef",
																			"organization",
																			"teamProject",
																		]
																		type: "object"
																	}
																	bitbucket: {
																		properties: {
																			allBranches: type: "boolean"
																			appPasswordRef: {
																				properties: {
																					key: type: "string"
																					secretName: type: "string"
																				}
																				required: [
																					"key",
																					"secretName",
																				]
																				type: "object"
																			}
																			owner: type: "string"
																			user: type: "string"
																		}
																		required: [
																			"appPasswordRef",
																			"owner",
																			"user",
																		]
																		type: "object"
																	}
																	bitbucketServer: {
																		properties: {
																			allBranches: type: "boolean"
																			api: type: "string"
																			basicAuth: {
																				properties: {
																					passwordRef: {
																						properties: {
																							key: type: "string"
																							secretName: type: "string"
																						}
																						required: [
																							"key",
																							"secretName",
																						]
																						type: "object"
																					}
																					username: type: "string"
																				}
																				required: [
																					"passwordRef",
																					"username",
																				]
																				type: "object"
																			}
																			project: type: "string"
																		}
																		required: [
																			"api",
																			"project",
																		]
																		type: "object"
																	}
																	cloneProtocol: type: "string"
																	filters: {
																		items: {
																			properties: {
																				branchMatch: type: "string"
																				labelMatch: type: "string"
																				pathsDoNotExist: {
																					items: type: "string"
																					type: "array"
																				}
																				pathsExist: {
																					items: type: "string"
																					type: "array"
																				}
																				repositoryMatch: type: "string"
																			}
																			type: "object"
																		}
																		type: "array"
																	}
																	gitea: {
																		properties: {
																			allBranches: type: "boolean"
																			api: type: "string"
																			insecure: type: "boolean"
																			owner: type: "string"
																			tokenRef: {
																				properties: {
																					key: type: "string"
																					secretName: type: "string"
																				}
																				required: [
																					"key",
																					"secretName",
																				]
																				type: "object"
																			}
																		}
																		required: [
																			"api",
																			"owner",
																		]
																		type: "object"
																	}
																	github: {
																		properties: {
																			allBranches: type: "boolean"
																			api: type: "string"
																			appSecretName: type: "string"
																			organization: type: "string"
																			tokenRef: {
																				properties: {
																					key: type: "string"
																					secretName: type: "string"
																				}
																				required: [
																					"key",
																					"secretName",
																				]
																				type: "object"
																			}
																		}
																		required: ["organization"]
																		type: "object"
																	}
																	gitlab: {
																		properties: {
																			allBranches: type: "boolean"
																			api: type: "string"
																			group: type: "string"
																			includeSubgroups: type: "boolean"
																			tokenRef: {
																				properties: {
																					key: type: "string"
																					secretName: type: "string"
																				}
																				required: [
																					"key",
																					"secretName",
																				]
																				type: "object"
																			}
																		}
																		required: ["group"]
																		type: "object"
																	}
																	requeueAfterSeconds: {
																		format: "int64"
																		type:   "integer"
																	}
																	template: {
																		properties: {
																			metadata: {
																				properties: {
																					annotations: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					finalizers: {
																						items: type: "string"
																						type: "array"
																					}
																					labels: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					name: type: "string"
																					namespace: type: "string"
																				}
																				type: "object"
																			}
																			spec: {
																				properties: {
																					destination: {
																						properties: {
																							name: type: "string"
																							namespace: type: "string"
																							server: type: "string"
																						}
																						type: "object"
																					}
																					ignoreDifferences: {
																						items: {
																							properties: {
																								group: type: "string"
																								jqPathExpressions: {
																									items: type: "string"
																									type: "array"
																								}
																								jsonPointers: {
																									items: type: "string"
																									type: "array"
																								}
																								kind: type: "string"
																								managedFieldsManagers: {
																									items: type: "string"
																									type: "array"
																								}
																								name: type: "string"
																								namespace: type: "string"
																							}
																							required: ["kind"]
																							type: "object"
																						}
																						type: "array"
																					}
																					info: {
																						items: {
																							properties: {
																								name: type: "string"
																								value: type: "string"
																							}
																							required: [
																								"name",
																								"value",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					project: type: "string"
																					revisionHistoryLimit: {
																						format: "int64"
																						type:   "integer"
																					}
																					source: {
																						properties: {
																							chart: type: "string"
																							directory: {
																								properties: {
																									exclude: type: "string"
																									include: type: "string"
																									jsonnet: {
																										properties: {
																											extVars: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																											libs: {
																												items: type: "string"
																												type: "array"
																											}
																											tlas: {
																												items: {
																													properties: {
																														code: type: "boolean"
																														name: type: "string"
																														value: type: "string"
																													}
																													required: [
																														"name",
																														"value",
																													]
																													type: "object"
																												}
																												type: "array"
																											}
																										}
																										type: "object"
																									}
																									recurse: type: "boolean"
																								}
																								type: "object"
																							}
																							helm: {
																								properties: {
																									fileParameters: {
																										items: {
																											properties: {
																												name: type: "string"
																												path: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									ignoreMissingValueFiles: type: "boolean"
																									parameters: {
																										items: {
																											properties: {
																												forceString: type: "boolean"
																												name: type: "string"
																												value: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																									passCredentials: type: "boolean"
																									releaseName: type: "string"
																									skipCrds: type: "boolean"
																									valueFiles: {
																										items: type: "string"
																										type: "array"
																									}
																									values: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							kustomize: {
																								properties: {
																									commonAnnotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									commonLabels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									forceCommonAnnotations: type: "boolean"
																									forceCommonLabels: type: "boolean"
																									images: {
																										items: type: "string"
																										type: "array"
																									}
																									namePrefix: type: "string"
																									nameSuffix: type: "string"
																									version: type: "string"
																								}
																								type: "object"
																							}
																							path: type: "string"
																							plugin: {
																								properties: {
																									env: {
																										items: {
																											properties: {
																												name: type: "string"
																												value: type: "string"
																											}
																											required: [
																												"name",
																												"value",
																											]
																											type: "object"
																										}
																										type: "array"
																									}
																									name: type: "string"
																									parameters: {
																										items: {
																											properties: {
																												array: {
																													items: type: "string"
																													type: "array"
																												}
																												map: {
																													additionalProperties: type: "string"
																													type: "object"
																												}
																												name: type: "string"
																												string: type: "string"
																											}
																											type: "object"
																										}
																										type: "array"
																									}
																								}
																								type: "object"
																							}
																							ref: type: "string"
																							repoURL: type: "string"
																							targetRevision: type: "string"
																						}
																						required: ["repoURL"]
																						type: "object"
																					}
																					sources: {
																						items: {
																							properties: {
																								chart: type: "string"
																								directory: {
																									properties: {
																										exclude: type: "string"
																										include: type: "string"
																										jsonnet: {
																											properties: {
																												extVars: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																												libs: {
																													items: type: "string"
																													type: "array"
																												}
																												tlas: {
																													items: {
																														properties: {
																															code: type: "boolean"
																															name: type: "string"
																															value: type: "string"
																														}
																														required: [
																															"name",
																															"value",
																														]
																														type: "object"
																													}
																													type: "array"
																												}
																											}
																											type: "object"
																										}
																										recurse: type: "boolean"
																									}
																									type: "object"
																								}
																								helm: {
																									properties: {
																										fileParameters: {
																											items: {
																												properties: {
																													name: type: "string"
																													path: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										ignoreMissingValueFiles: type: "boolean"
																										parameters: {
																											items: {
																												properties: {
																													forceString: type: "boolean"
																													name: type: "string"
																													value: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																										passCredentials: type: "boolean"
																										releaseName: type: "string"
																										skipCrds: type: "boolean"
																										valueFiles: {
																											items: type: "string"
																											type: "array"
																										}
																										values: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								kustomize: {
																									properties: {
																										commonAnnotations: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										commonLabels: {
																											additionalProperties: type: "string"
																											type: "object"
																										}
																										forceCommonAnnotations: type: "boolean"
																										forceCommonLabels: type: "boolean"
																										images: {
																											items: type: "string"
																											type: "array"
																										}
																										namePrefix: type: "string"
																										nameSuffix: type: "string"
																										version: type: "string"
																									}
																									type: "object"
																								}
																								path: type: "string"
																								plugin: {
																									properties: {
																										env: {
																											items: {
																												properties: {
																													name: type: "string"
																													value: type: "string"
																												}
																												required: [
																													"name",
																													"value",
																												]
																												type: "object"
																											}
																											type: "array"
																										}
																										name: type: "string"
																										parameters: {
																											items: {
																												properties: {
																													array: {
																														items: type: "string"
																														type: "array"
																													}
																													map: {
																														additionalProperties: type: "string"
																														type: "object"
																													}
																													name: type: "string"
																													string: type: "string"
																												}
																												type: "object"
																											}
																											type: "array"
																										}
																									}
																									type: "object"
																								}
																								ref: type: "string"
																								repoURL: type: "string"
																								targetRevision: type: "string"
																							}
																							required: ["repoURL"]
																							type: "object"
																						}
																						type: "array"
																					}
																					syncPolicy: {
																						properties: {
																							automated: {
																								properties: {
																									allowEmpty: type: "boolean"
																									prune: type: "boolean"
																									selfHeal: type: "boolean"
																								}
																								type: "object"
																							}
																							managedNamespaceMetadata: {
																								properties: {
																									annotations: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																									labels: {
																										additionalProperties: type: "string"
																										type: "object"
																									}
																								}
																								type: "object"
																							}
																							retry: {
																								properties: {
																									backoff: {
																										properties: {
																											duration: type: "string"
																											factor: {
																												format: "int64"
																												type:   "integer"
																											}
																											maxDuration: type: "string"
																										}
																										type: "object"
																									}
																									limit: {
																										format: "int64"
																										type:   "integer"
																									}
																								}
																								type: "object"
																							}
																							syncOptions: {
																								items: type: "string"
																								type: "array"
																							}
																						}
																						type: "object"
																					}
																				}
																				required: [
																					"destination",
																					"project",
																				]
																				type: "object"
																			}
																		}
																		required: [
																			"metadata",
																			"spec",
																		]
																		type: "object"
																	}
																}
																type: "object"
															}
															selector: {
																properties: {
																	matchExpressions: {
																		items: {
																			properties: {
																				key: type: "string"
																				operator: type: "string"
																				values: {
																					items: type: "string"
																					type: "array"
																				}
																			}
																			required: [
																				"key",
																				"operator",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	matchLabels: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																}
																type: "object"
															}
														}
														type: "object"
													}
													type: "array"
												}
												mergeKeys: {
													items: type: "string"
													type: "array"
												}
												template: {
													properties: {
														metadata: {
															properties: {
																annotations: {
																	additionalProperties: type: "string"
																	type: "object"
																}
																finalizers: {
																	items: type: "string"
																	type: "array"
																}
																labels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
																name: type: "string"
																namespace: type: "string"
															}
															type: "object"
														}
														spec: {
															properties: {
																destination: {
																	properties: {
																		name: type: "string"
																		namespace: type: "string"
																		server: type: "string"
																	}
																	type: "object"
																}
																ignoreDifferences: {
																	items: {
																		properties: {
																			group: type: "string"
																			jqPathExpressions: {
																				items: type: "string"
																				type: "array"
																			}
																			jsonPointers: {
																				items: type: "string"
																				type: "array"
																			}
																			kind: type: "string"
																			managedFieldsManagers: {
																				items: type: "string"
																				type: "array"
																			}
																			name: type: "string"
																			namespace: type: "string"
																		}
																		required: ["kind"]
																		type: "object"
																	}
																	type: "array"
																}
																info: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																project: type: "string"
																revisionHistoryLimit: {
																	format: "int64"
																	type:   "integer"
																}
																source: {
																	properties: {
																		chart: type: "string"
																		directory: {
																			properties: {
																				exclude: type: "string"
																				include: type: "string"
																				jsonnet: {
																					properties: {
																						extVars: {
																							items: {
																								properties: {
																									code: type: "boolean"
																									name: type: "string"
																									value: type: "string"
																								}
																								required: [
																									"name",
																									"value",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																						libs: {
																							items: type: "string"
																							type: "array"
																						}
																						tlas: {
																							items: {
																								properties: {
																									code: type: "boolean"
																									name: type: "string"
																									value: type: "string"
																								}
																								required: [
																									"name",
																									"value",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																					}
																					type: "object"
																				}
																				recurse: type: "boolean"
																			}
																			type: "object"
																		}
																		helm: {
																			properties: {
																				fileParameters: {
																					items: {
																						properties: {
																							name: type: "string"
																							path: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																				ignoreMissingValueFiles: type: "boolean"
																				parameters: {
																					items: {
																						properties: {
																							forceString: type: "boolean"
																							name: type: "string"
																							value: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																				passCredentials: type: "boolean"
																				releaseName: type: "string"
																				skipCrds: type: "boolean"
																				valueFiles: {
																					items: type: "string"
																					type: "array"
																				}
																				values: type: "string"
																				version: type: "string"
																			}
																			type: "object"
																		}
																		kustomize: {
																			properties: {
																				commonAnnotations: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				commonLabels: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				forceCommonAnnotations: type: "boolean"
																				forceCommonLabels: type: "boolean"
																				images: {
																					items: type: "string"
																					type: "array"
																				}
																				namePrefix: type: "string"
																				nameSuffix: type: "string"
																				version: type: "string"
																			}
																			type: "object"
																		}
																		path: type: "string"
																		plugin: {
																			properties: {
																				env: {
																					items: {
																						properties: {
																							name: type: "string"
																							value: type: "string"
																						}
																						required: [
																							"name",
																							"value",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				name: type: "string"
																				parameters: {
																					items: {
																						properties: {
																							array: {
																								items: type: "string"
																								type: "array"
																							}
																							map: {
																								additionalProperties: type: "string"
																								type: "object"
																							}
																							name: type: "string"
																							string: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																			}
																			type: "object"
																		}
																		ref: type: "string"
																		repoURL: type: "string"
																		targetRevision: type: "string"
																	}
																	required: ["repoURL"]
																	type: "object"
																}
																sources: {
																	items: {
																		properties: {
																			chart: type: "string"
																			directory: {
																				properties: {
																					exclude: type: "string"
																					include: type: "string"
																					jsonnet: {
																						properties: {
																							extVars: {
																								items: {
																									properties: {
																										code: type: "boolean"
																										name: type: "string"
																										value: type: "string"
																									}
																									required: [
																										"name",
																										"value",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																							libs: {
																								items: type: "string"
																								type: "array"
																							}
																							tlas: {
																								items: {
																									properties: {
																										code: type: "boolean"
																										name: type: "string"
																										value: type: "string"
																									}
																									required: [
																										"name",
																										"value",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																						}
																						type: "object"
																					}
																					recurse: type: "boolean"
																				}
																				type: "object"
																			}
																			helm: {
																				properties: {
																					fileParameters: {
																						items: {
																							properties: {
																								name: type: "string"
																								path: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																					ignoreMissingValueFiles: type: "boolean"
																					parameters: {
																						items: {
																							properties: {
																								forceString: type: "boolean"
																								name: type: "string"
																								value: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																					passCredentials: type: "boolean"
																					releaseName: type: "string"
																					skipCrds: type: "boolean"
																					valueFiles: {
																						items: type: "string"
																						type: "array"
																					}
																					values: type: "string"
																					version: type: "string"
																				}
																				type: "object"
																			}
																			kustomize: {
																				properties: {
																					commonAnnotations: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					commonLabels: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					forceCommonAnnotations: type: "boolean"
																					forceCommonLabels: type: "boolean"
																					images: {
																						items: type: "string"
																						type: "array"
																					}
																					namePrefix: type: "string"
																					nameSuffix: type: "string"
																					version: type: "string"
																				}
																				type: "object"
																			}
																			path: type: "string"
																			plugin: {
																				properties: {
																					env: {
																						items: {
																							properties: {
																								name: type: "string"
																								value: type: "string"
																							}
																							required: [
																								"name",
																								"value",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					name: type: "string"
																					parameters: {
																						items: {
																							properties: {
																								array: {
																									items: type: "string"
																									type: "array"
																								}
																								map: {
																									additionalProperties: type: "string"
																									type: "object"
																								}
																								name: type: "string"
																								string: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																				}
																				type: "object"
																			}
																			ref: type: "string"
																			repoURL: type: "string"
																			targetRevision: type: "string"
																		}
																		required: ["repoURL"]
																		type: "object"
																	}
																	type: "array"
																}
																syncPolicy: {
																	properties: {
																		automated: {
																			properties: {
																				allowEmpty: type: "boolean"
																				prune: type: "boolean"
																				selfHeal: type: "boolean"
																			}
																			type: "object"
																		}
																		managedNamespaceMetadata: {
																			properties: {
																				annotations: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				labels: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																			}
																			type: "object"
																		}
																		retry: {
																			properties: {
																				backoff: {
																					properties: {
																						duration: type: "string"
																						factor: {
																							format: "int64"
																							type:   "integer"
																						}
																						maxDuration: type: "string"
																					}
																					type: "object"
																				}
																				limit: {
																					format: "int64"
																					type:   "integer"
																				}
																			}
																			type: "object"
																		}
																		syncOptions: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	type: "object"
																}
															}
															required: [
																"destination",
																"project",
															]
															type: "object"
														}
													}
													required: [
														"metadata",
														"spec",
													]
													type: "object"
												}
											}
											required: [
												"generators",
												"mergeKeys",
											]
											type: "object"
										}
										pullRequest: {
											properties: {
												bitbucketServer: {
													properties: {
														api: type: "string"
														basicAuth: {
															properties: {
																passwordRef: {
																	properties: {
																		key: type: "string"
																		secretName: type: "string"
																	}
																	required: [
																		"key",
																		"secretName",
																	]
																	type: "object"
																}
																username: type: "string"
															}
															required: [
																"passwordRef",
																"username",
															]
															type: "object"
														}
														project: type: "string"
														repo: type: "string"
													}
													required: [
														"api",
														"project",
														"repo",
													]
													type: "object"
												}
												filters: {
													items: {
														properties: branchMatch: type: "string"
														type: "object"
													}
													type: "array"
												}
												gitea: {
													properties: {
														api: type: "string"
														insecure: type: "boolean"
														owner: type: "string"
														repo: type: "string"
														tokenRef: {
															properties: {
																key: type: "string"
																secretName: type: "string"
															}
															required: [
																"key",
																"secretName",
															]
															type: "object"
														}
													}
													required: [
														"api",
														"owner",
														"repo",
													]
													type: "object"
												}
												github: {
													properties: {
														api: type: "string"
														appSecretName: type: "string"
														labels: {
															items: type: "string"
															type: "array"
														}
														owner: type: "string"
														repo: type: "string"
														tokenRef: {
															properties: {
																key: type: "string"
																secretName: type: "string"
															}
															required: [
																"key",
																"secretName",
															]
															type: "object"
														}
													}
													required: [
														"owner",
														"repo",
													]
													type: "object"
												}
												gitlab: {
													properties: {
														api: type: "string"
														labels: {
															items: type: "string"
															type: "array"
														}
														project: type: "string"
														pullRequestState: type: "string"
														tokenRef: {
															properties: {
																key: type: "string"
																secretName: type: "string"
															}
															required: [
																"key",
																"secretName",
															]
															type: "object"
														}
													}
													required: ["project"]
													type: "object"
												}
												requeueAfterSeconds: {
													format: "int64"
													type:   "integer"
												}
												template: {
													properties: {
														metadata: {
															properties: {
																annotations: {
																	additionalProperties: type: "string"
																	type: "object"
																}
																finalizers: {
																	items: type: "string"
																	type: "array"
																}
																labels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
																name: type: "string"
																namespace: type: "string"
															}
															type: "object"
														}
														spec: {
															properties: {
																destination: {
																	properties: {
																		name: type: "string"
																		namespace: type: "string"
																		server: type: "string"
																	}
																	type: "object"
																}
																ignoreDifferences: {
																	items: {
																		properties: {
																			group: type: "string"
																			jqPathExpressions: {
																				items: type: "string"
																				type: "array"
																			}
																			jsonPointers: {
																				items: type: "string"
																				type: "array"
																			}
																			kind: type: "string"
																			managedFieldsManagers: {
																				items: type: "string"
																				type: "array"
																			}
																			name: type: "string"
																			namespace: type: "string"
																		}
																		required: ["kind"]
																		type: "object"
																	}
																	type: "array"
																}
																info: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																project: type: "string"
																revisionHistoryLimit: {
																	format: "int64"
																	type:   "integer"
																}
																source: {
																	properties: {
																		chart: type: "string"
																		directory: {
																			properties: {
																				exclude: type: "string"
																				include: type: "string"
																				jsonnet: {
																					properties: {
																						extVars: {
																							items: {
																								properties: {
																									code: type: "boolean"
																									name: type: "string"
																									value: type: "string"
																								}
																								required: [
																									"name",
																									"value",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																						libs: {
																							items: type: "string"
																							type: "array"
																						}
																						tlas: {
																							items: {
																								properties: {
																									code: type: "boolean"
																									name: type: "string"
																									value: type: "string"
																								}
																								required: [
																									"name",
																									"value",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																					}
																					type: "object"
																				}
																				recurse: type: "boolean"
																			}
																			type: "object"
																		}
																		helm: {
																			properties: {
																				fileParameters: {
																					items: {
																						properties: {
																							name: type: "string"
																							path: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																				ignoreMissingValueFiles: type: "boolean"
																				parameters: {
																					items: {
																						properties: {
																							forceString: type: "boolean"
																							name: type: "string"
																							value: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																				passCredentials: type: "boolean"
																				releaseName: type: "string"
																				skipCrds: type: "boolean"
																				valueFiles: {
																					items: type: "string"
																					type: "array"
																				}
																				values: type: "string"
																				version: type: "string"
																			}
																			type: "object"
																		}
																		kustomize: {
																			properties: {
																				commonAnnotations: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				commonLabels: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				forceCommonAnnotations: type: "boolean"
																				forceCommonLabels: type: "boolean"
																				images: {
																					items: type: "string"
																					type: "array"
																				}
																				namePrefix: type: "string"
																				nameSuffix: type: "string"
																				version: type: "string"
																			}
																			type: "object"
																		}
																		path: type: "string"
																		plugin: {
																			properties: {
																				env: {
																					items: {
																						properties: {
																							name: type: "string"
																							value: type: "string"
																						}
																						required: [
																							"name",
																							"value",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				name: type: "string"
																				parameters: {
																					items: {
																						properties: {
																							array: {
																								items: type: "string"
																								type: "array"
																							}
																							map: {
																								additionalProperties: type: "string"
																								type: "object"
																							}
																							name: type: "string"
																							string: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																			}
																			type: "object"
																		}
																		ref: type: "string"
																		repoURL: type: "string"
																		targetRevision: type: "string"
																	}
																	required: ["repoURL"]
																	type: "object"
																}
																sources: {
																	items: {
																		properties: {
																			chart: type: "string"
																			directory: {
																				properties: {
																					exclude: type: "string"
																					include: type: "string"
																					jsonnet: {
																						properties: {
																							extVars: {
																								items: {
																									properties: {
																										code: type: "boolean"
																										name: type: "string"
																										value: type: "string"
																									}
																									required: [
																										"name",
																										"value",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																							libs: {
																								items: type: "string"
																								type: "array"
																							}
																							tlas: {
																								items: {
																									properties: {
																										code: type: "boolean"
																										name: type: "string"
																										value: type: "string"
																									}
																									required: [
																										"name",
																										"value",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																						}
																						type: "object"
																					}
																					recurse: type: "boolean"
																				}
																				type: "object"
																			}
																			helm: {
																				properties: {
																					fileParameters: {
																						items: {
																							properties: {
																								name: type: "string"
																								path: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																					ignoreMissingValueFiles: type: "boolean"
																					parameters: {
																						items: {
																							properties: {
																								forceString: type: "boolean"
																								name: type: "string"
																								value: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																					passCredentials: type: "boolean"
																					releaseName: type: "string"
																					skipCrds: type: "boolean"
																					valueFiles: {
																						items: type: "string"
																						type: "array"
																					}
																					values: type: "string"
																					version: type: "string"
																				}
																				type: "object"
																			}
																			kustomize: {
																				properties: {
																					commonAnnotations: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					commonLabels: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					forceCommonAnnotations: type: "boolean"
																					forceCommonLabels: type: "boolean"
																					images: {
																						items: type: "string"
																						type: "array"
																					}
																					namePrefix: type: "string"
																					nameSuffix: type: "string"
																					version: type: "string"
																				}
																				type: "object"
																			}
																			path: type: "string"
																			plugin: {
																				properties: {
																					env: {
																						items: {
																							properties: {
																								name: type: "string"
																								value: type: "string"
																							}
																							required: [
																								"name",
																								"value",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					name: type: "string"
																					parameters: {
																						items: {
																							properties: {
																								array: {
																									items: type: "string"
																									type: "array"
																								}
																								map: {
																									additionalProperties: type: "string"
																									type: "object"
																								}
																								name: type: "string"
																								string: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																				}
																				type: "object"
																			}
																			ref: type: "string"
																			repoURL: type: "string"
																			targetRevision: type: "string"
																		}
																		required: ["repoURL"]
																		type: "object"
																	}
																	type: "array"
																}
																syncPolicy: {
																	properties: {
																		automated: {
																			properties: {
																				allowEmpty: type: "boolean"
																				prune: type: "boolean"
																				selfHeal: type: "boolean"
																			}
																			type: "object"
																		}
																		managedNamespaceMetadata: {
																			properties: {
																				annotations: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				labels: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																			}
																			type: "object"
																		}
																		retry: {
																			properties: {
																				backoff: {
																					properties: {
																						duration: type: "string"
																						factor: {
																							format: "int64"
																							type:   "integer"
																						}
																						maxDuration: type: "string"
																					}
																					type: "object"
																				}
																				limit: {
																					format: "int64"
																					type:   "integer"
																				}
																			}
																			type: "object"
																		}
																		syncOptions: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	type: "object"
																}
															}
															required: [
																"destination",
																"project",
															]
															type: "object"
														}
													}
													required: [
														"metadata",
														"spec",
													]
													type: "object"
												}
											}
											type: "object"
										}
										scmProvider: {
											properties: {
												azureDevOps: {
													properties: {
														accessTokenRef: {
															properties: {
																key: type: "string"
																secretName: type: "string"
															}
															required: [
																"key",
																"secretName",
															]
															type: "object"
														}
														allBranches: type: "boolean"
														api: type: "string"
														organization: type: "string"
														teamProject: type: "string"
													}
													required: [
														"accessTokenRef",
														"organization",
														"teamProject",
													]
													type: "object"
												}
												bitbucket: {
													properties: {
														allBranches: type: "boolean"
														appPasswordRef: {
															properties: {
																key: type: "string"
																secretName: type: "string"
															}
															required: [
																"key",
																"secretName",
															]
															type: "object"
														}
														owner: type: "string"
														user: type: "string"
													}
													required: [
														"appPasswordRef",
														"owner",
														"user",
													]
													type: "object"
												}
												bitbucketServer: {
													properties: {
														allBranches: type: "boolean"
														api: type: "string"
														basicAuth: {
															properties: {
																passwordRef: {
																	properties: {
																		key: type: "string"
																		secretName: type: "string"
																	}
																	required: [
																		"key",
																		"secretName",
																	]
																	type: "object"
																}
																username: type: "string"
															}
															required: [
																"passwordRef",
																"username",
															]
															type: "object"
														}
														project: type: "string"
													}
													required: [
														"api",
														"project",
													]
													type: "object"
												}
												cloneProtocol: type: "string"
												filters: {
													items: {
														properties: {
															branchMatch: type: "string"
															labelMatch: type: "string"
															pathsDoNotExist: {
																items: type: "string"
																type: "array"
															}
															pathsExist: {
																items: type: "string"
																type: "array"
															}
															repositoryMatch: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												gitea: {
													properties: {
														allBranches: type: "boolean"
														api: type: "string"
														insecure: type: "boolean"
														owner: type: "string"
														tokenRef: {
															properties: {
																key: type: "string"
																secretName: type: "string"
															}
															required: [
																"key",
																"secretName",
															]
															type: "object"
														}
													}
													required: [
														"api",
														"owner",
													]
													type: "object"
												}
												github: {
													properties: {
														allBranches: type: "boolean"
														api: type: "string"
														appSecretName: type: "string"
														organization: type: "string"
														tokenRef: {
															properties: {
																key: type: "string"
																secretName: type: "string"
															}
															required: [
																"key",
																"secretName",
															]
															type: "object"
														}
													}
													required: ["organization"]
													type: "object"
												}
												gitlab: {
													properties: {
														allBranches: type: "boolean"
														api: type: "string"
														group: type: "string"
														includeSubgroups: type: "boolean"
														tokenRef: {
															properties: {
																key: type: "string"
																secretName: type: "string"
															}
															required: [
																"key",
																"secretName",
															]
															type: "object"
														}
													}
													required: ["group"]
													type: "object"
												}
												requeueAfterSeconds: {
													format: "int64"
													type:   "integer"
												}
												template: {
													properties: {
														metadata: {
															properties: {
																annotations: {
																	additionalProperties: type: "string"
																	type: "object"
																}
																finalizers: {
																	items: type: "string"
																	type: "array"
																}
																labels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
																name: type: "string"
																namespace: type: "string"
															}
															type: "object"
														}
														spec: {
															properties: {
																destination: {
																	properties: {
																		name: type: "string"
																		namespace: type: "string"
																		server: type: "string"
																	}
																	type: "object"
																}
																ignoreDifferences: {
																	items: {
																		properties: {
																			group: type: "string"
																			jqPathExpressions: {
																				items: type: "string"
																				type: "array"
																			}
																			jsonPointers: {
																				items: type: "string"
																				type: "array"
																			}
																			kind: type: "string"
																			managedFieldsManagers: {
																				items: type: "string"
																				type: "array"
																			}
																			name: type: "string"
																			namespace: type: "string"
																		}
																		required: ["kind"]
																		type: "object"
																	}
																	type: "array"
																}
																info: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																project: type: "string"
																revisionHistoryLimit: {
																	format: "int64"
																	type:   "integer"
																}
																source: {
																	properties: {
																		chart: type: "string"
																		directory: {
																			properties: {
																				exclude: type: "string"
																				include: type: "string"
																				jsonnet: {
																					properties: {
																						extVars: {
																							items: {
																								properties: {
																									code: type: "boolean"
																									name: type: "string"
																									value: type: "string"
																								}
																								required: [
																									"name",
																									"value",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																						libs: {
																							items: type: "string"
																							type: "array"
																						}
																						tlas: {
																							items: {
																								properties: {
																									code: type: "boolean"
																									name: type: "string"
																									value: type: "string"
																								}
																								required: [
																									"name",
																									"value",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																					}
																					type: "object"
																				}
																				recurse: type: "boolean"
																			}
																			type: "object"
																		}
																		helm: {
																			properties: {
																				fileParameters: {
																					items: {
																						properties: {
																							name: type: "string"
																							path: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																				ignoreMissingValueFiles: type: "boolean"
																				parameters: {
																					items: {
																						properties: {
																							forceString: type: "boolean"
																							name: type: "string"
																							value: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																				passCredentials: type: "boolean"
																				releaseName: type: "string"
																				skipCrds: type: "boolean"
																				valueFiles: {
																					items: type: "string"
																					type: "array"
																				}
																				values: type: "string"
																				version: type: "string"
																			}
																			type: "object"
																		}
																		kustomize: {
																			properties: {
																				commonAnnotations: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				commonLabels: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				forceCommonAnnotations: type: "boolean"
																				forceCommonLabels: type: "boolean"
																				images: {
																					items: type: "string"
																					type: "array"
																				}
																				namePrefix: type: "string"
																				nameSuffix: type: "string"
																				version: type: "string"
																			}
																			type: "object"
																		}
																		path: type: "string"
																		plugin: {
																			properties: {
																				env: {
																					items: {
																						properties: {
																							name: type: "string"
																							value: type: "string"
																						}
																						required: [
																							"name",
																							"value",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				name: type: "string"
																				parameters: {
																					items: {
																						properties: {
																							array: {
																								items: type: "string"
																								type: "array"
																							}
																							map: {
																								additionalProperties: type: "string"
																								type: "object"
																							}
																							name: type: "string"
																							string: type: "string"
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																			}
																			type: "object"
																		}
																		ref: type: "string"
																		repoURL: type: "string"
																		targetRevision: type: "string"
																	}
																	required: ["repoURL"]
																	type: "object"
																}
																sources: {
																	items: {
																		properties: {
																			chart: type: "string"
																			directory: {
																				properties: {
																					exclude: type: "string"
																					include: type: "string"
																					jsonnet: {
																						properties: {
																							extVars: {
																								items: {
																									properties: {
																										code: type: "boolean"
																										name: type: "string"
																										value: type: "string"
																									}
																									required: [
																										"name",
																										"value",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																							libs: {
																								items: type: "string"
																								type: "array"
																							}
																							tlas: {
																								items: {
																									properties: {
																										code: type: "boolean"
																										name: type: "string"
																										value: type: "string"
																									}
																									required: [
																										"name",
																										"value",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																						}
																						type: "object"
																					}
																					recurse: type: "boolean"
																				}
																				type: "object"
																			}
																			helm: {
																				properties: {
																					fileParameters: {
																						items: {
																							properties: {
																								name: type: "string"
																								path: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																					ignoreMissingValueFiles: type: "boolean"
																					parameters: {
																						items: {
																							properties: {
																								forceString: type: "boolean"
																								name: type: "string"
																								value: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																					passCredentials: type: "boolean"
																					releaseName: type: "string"
																					skipCrds: type: "boolean"
																					valueFiles: {
																						items: type: "string"
																						type: "array"
																					}
																					values: type: "string"
																					version: type: "string"
																				}
																				type: "object"
																			}
																			kustomize: {
																				properties: {
																					commonAnnotations: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					commonLabels: {
																						additionalProperties: type: "string"
																						type: "object"
																					}
																					forceCommonAnnotations: type: "boolean"
																					forceCommonLabels: type: "boolean"
																					images: {
																						items: type: "string"
																						type: "array"
																					}
																					namePrefix: type: "string"
																					nameSuffix: type: "string"
																					version: type: "string"
																				}
																				type: "object"
																			}
																			path: type: "string"
																			plugin: {
																				properties: {
																					env: {
																						items: {
																							properties: {
																								name: type: "string"
																								value: type: "string"
																							}
																							required: [
																								"name",
																								"value",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					name: type: "string"
																					parameters: {
																						items: {
																							properties: {
																								array: {
																									items: type: "string"
																									type: "array"
																								}
																								map: {
																									additionalProperties: type: "string"
																									type: "object"
																								}
																								name: type: "string"
																								string: type: "string"
																							}
																							type: "object"
																						}
																						type: "array"
																					}
																				}
																				type: "object"
																			}
																			ref: type: "string"
																			repoURL: type: "string"
																			targetRevision: type: "string"
																		}
																		required: ["repoURL"]
																		type: "object"
																	}
																	type: "array"
																}
																syncPolicy: {
																	properties: {
																		automated: {
																			properties: {
																				allowEmpty: type: "boolean"
																				prune: type: "boolean"
																				selfHeal: type: "boolean"
																			}
																			type: "object"
																		}
																		managedNamespaceMetadata: {
																			properties: {
																				annotations: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																				labels: {
																					additionalProperties: type: "string"
																					type: "object"
																				}
																			}
																			type: "object"
																		}
																		retry: {
																			properties: {
																				backoff: {
																					properties: {
																						duration: type: "string"
																						factor: {
																							format: "int64"
																							type:   "integer"
																						}
																						maxDuration: type: "string"
																					}
																					type: "object"
																				}
																				limit: {
																					format: "int64"
																					type:   "integer"
																				}
																			}
																			type: "object"
																		}
																		syncOptions: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	type: "object"
																}
															}
															required: [
																"destination",
																"project",
															]
															type: "object"
														}
													}
													required: [
														"metadata",
														"spec",
													]
													type: "object"
												}
											}
											type: "object"
										}
										selector: {
											properties: {
												matchExpressions: {
													items: {
														properties: {
															key: type: "string"
															operator: type: "string"
															values: {
																items: type: "string"
																type: "array"
															}
														}
														required: [
															"key",
															"operator",
														]
														type: "object"
													}
													type: "array"
												}
												matchLabels: {
													additionalProperties: type: "string"
													type: "object"
												}
											}
											type: "object"
										}
									}
									type: "object"
								}
								type: "array"
							}
							goTemplate: type: "boolean"
							strategy: {
								properties: {
									rollingSync: {
										properties: steps: {
											items: {
												properties: {
													matchExpressions: {
														items: {
															properties: {
																key: type: "string"
																operator: type: "string"
																values: {
																	items: type: "string"
																	type: "array"
																}
															}
															type: "object"
														}
														type: "array"
													}
													maxUpdate: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														"x-kubernetes-int-or-string": true
													}
												}
												type: "object"
											}
											type: "array"
										}
										type: "object"
									}
									type: type: "string"
								}
								type: "object"
							}
							syncPolicy: {
								properties: preserveResourcesOnDeletion: type: "boolean"
								type: "object"
							}
							template: {
								properties: {
									metadata: {
										properties: {
											annotations: {
												additionalProperties: type: "string"
												type: "object"
											}
											finalizers: {
												items: type: "string"
												type: "array"
											}
											labels: {
												additionalProperties: type: "string"
												type: "object"
											}
											name: type: "string"
											namespace: type: "string"
										}
										type: "object"
									}
									spec: {
										properties: {
											destination: {
												properties: {
													name: type: "string"
													namespace: type: "string"
													server: type: "string"
												}
												type: "object"
											}
											ignoreDifferences: {
												items: {
													properties: {
														group: type: "string"
														jqPathExpressions: {
															items: type: "string"
															type: "array"
														}
														jsonPointers: {
															items: type: "string"
															type: "array"
														}
														kind: type: "string"
														managedFieldsManagers: {
															items: type: "string"
															type: "array"
														}
														name: type: "string"
														namespace: type: "string"
													}
													required: ["kind"]
													type: "object"
												}
												type: "array"
											}
											info: {
												items: {
													properties: {
														name: type: "string"
														value: type: "string"
													}
													required: [
														"name",
														"value",
													]
													type: "object"
												}
												type: "array"
											}
											project: type: "string"
											revisionHistoryLimit: {
												format: "int64"
												type:   "integer"
											}
											source: {
												properties: {
													chart: type: "string"
													directory: {
														properties: {
															exclude: type: "string"
															include: type: "string"
															jsonnet: {
																properties: {
																	extVars: {
																		items: {
																			properties: {
																				code: type: "boolean"
																				name: type: "string"
																				value: type: "string"
																			}
																			required: [
																				"name",
																				"value",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	libs: {
																		items: type: "string"
																		type: "array"
																	}
																	tlas: {
																		items: {
																			properties: {
																				code: type: "boolean"
																				name: type: "string"
																				value: type: "string"
																			}
																			required: [
																				"name",
																				"value",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																}
																type: "object"
															}
															recurse: type: "boolean"
														}
														type: "object"
													}
													helm: {
														properties: {
															fileParameters: {
																items: {
																	properties: {
																		name: type: "string"
																		path: type: "string"
																	}
																	type: "object"
																}
																type: "array"
															}
															ignoreMissingValueFiles: type: "boolean"
															parameters: {
																items: {
																	properties: {
																		forceString: type: "boolean"
																		name: type: "string"
																		value: type: "string"
																	}
																	type: "object"
																}
																type: "array"
															}
															passCredentials: type: "boolean"
															releaseName: type: "string"
															skipCrds: type: "boolean"
															valueFiles: {
																items: type: "string"
																type: "array"
															}
															values: type: "string"
															version: type: "string"
														}
														type: "object"
													}
													kustomize: {
														properties: {
															commonAnnotations: {
																additionalProperties: type: "string"
																type: "object"
															}
															commonLabels: {
																additionalProperties: type: "string"
																type: "object"
															}
															forceCommonAnnotations: type: "boolean"
															forceCommonLabels: type: "boolean"
															images: {
																items: type: "string"
																type: "array"
															}
															namePrefix: type: "string"
															nameSuffix: type: "string"
															version: type: "string"
														}
														type: "object"
													}
													path: type: "string"
													plugin: {
														properties: {
															env: {
																items: {
																	properties: {
																		name: type: "string"
																		value: type: "string"
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																type: "array"
															}
															name: type: "string"
															parameters: {
																items: {
																	properties: {
																		array: {
																			items: type: "string"
																			type: "array"
																		}
																		map: {
																			additionalProperties: type: "string"
																			type: "object"
																		}
																		name: type: "string"
																		string: type: "string"
																	}
																	type: "object"
																}
																type: "array"
															}
														}
														type: "object"
													}
													ref: type: "string"
													repoURL: type: "string"
													targetRevision: type: "string"
												}
												required: ["repoURL"]
												type: "object"
											}
											sources: {
												items: {
													properties: {
														chart: type: "string"
														directory: {
															properties: {
																exclude: type: "string"
																include: type: "string"
																jsonnet: {
																	properties: {
																		extVars: {
																			items: {
																				properties: {
																					code: type: "boolean"
																					name: type: "string"
																					value: type: "string"
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		libs: {
																			items: type: "string"
																			type: "array"
																		}
																		tlas: {
																			items: {
																				properties: {
																					code: type: "boolean"
																					name: type: "string"
																					value: type: "string"
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																	}
																	type: "object"
																}
																recurse: type: "boolean"
															}
															type: "object"
														}
														helm: {
															properties: {
																fileParameters: {
																	items: {
																		properties: {
																			name: type: "string"
																			path: type: "string"
																		}
																		type: "object"
																	}
																	type: "array"
																}
																ignoreMissingValueFiles: type: "boolean"
																parameters: {
																	items: {
																		properties: {
																			forceString: type: "boolean"
																			name: type: "string"
																			value: type: "string"
																		}
																		type: "object"
																	}
																	type: "array"
																}
																passCredentials: type: "boolean"
																releaseName: type: "string"
																skipCrds: type: "boolean"
																valueFiles: {
																	items: type: "string"
																	type: "array"
																}
																values: type: "string"
																version: type: "string"
															}
															type: "object"
														}
														kustomize: {
															properties: {
																commonAnnotations: {
																	additionalProperties: type: "string"
																	type: "object"
																}
																commonLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
																forceCommonAnnotations: type: "boolean"
																forceCommonLabels: type: "boolean"
																images: {
																	items: type: "string"
																	type: "array"
																}
																namePrefix: type: "string"
																nameSuffix: type: "string"
																version: type: "string"
															}
															type: "object"
														}
														path: type: "string"
														plugin: {
															properties: {
																env: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																name: type: "string"
																parameters: {
																	items: {
																		properties: {
																			array: {
																				items: type: "string"
																				type: "array"
																			}
																			map: {
																				additionalProperties: type: "string"
																				type: "object"
																			}
																			name: type: "string"
																			string: type: "string"
																		}
																		type: "object"
																	}
																	type: "array"
																}
															}
															type: "object"
														}
														ref: type: "string"
														repoURL: type: "string"
														targetRevision: type: "string"
													}
													required: ["repoURL"]
													type: "object"
												}
												type: "array"
											}
											syncPolicy: {
												properties: {
													automated: {
														properties: {
															allowEmpty: type: "boolean"
															prune: type: "boolean"
															selfHeal: type: "boolean"
														}
														type: "object"
													}
													managedNamespaceMetadata: {
														properties: {
															annotations: {
																additionalProperties: type: "string"
																type: "object"
															}
															labels: {
																additionalProperties: type: "string"
																type: "object"
															}
														}
														type: "object"
													}
													retry: {
														properties: {
															backoff: {
																properties: {
																	duration: type: "string"
																	factor: {
																		format: "int64"
																		type:   "integer"
																	}
																	maxDuration: type: "string"
																}
																type: "object"
															}
															limit: {
																format: "int64"
																type:   "integer"
															}
														}
														type: "object"
													}
													syncOptions: {
														items: type: "string"
														type: "array"
													}
												}
												type: "object"
											}
										}
										required: [
											"destination",
											"project",
										]
										type: "object"
									}
								}
								required: [
									"metadata",
									"spec",
								]
								type: "object"
							}
						}
						required: [
							"generators",
							"template",
						]
						type: "object"
					}
					status: {
						properties: {
							applicationStatus: {
								items: {
									properties: {
										application: type: "string"
										lastTransitionTime: {
											format: "date-time"
											type:   "string"
										}
										message: type: "string"
										status: type: "string"
										step: type: "string"
									}
									required: [
										"application",
										"message",
										"status",
										"step",
									]
									type: "object"
								}
								type: "array"
							}
							conditions: {
								items: {
									properties: {
										lastTransitionTime: {
											format: "date-time"
											type:   "string"
										}
										message: type: "string"
										reason: type: "string"
										status: type: "string"
										type: type: "string"
									}
									required: [
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
						}
						type: "object"
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}